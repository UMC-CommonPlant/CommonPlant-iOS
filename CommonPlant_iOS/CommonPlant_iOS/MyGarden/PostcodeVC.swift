//
//  PostcodeViewController.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/02/06.
//

import UIKit
import WebKit

class PostcodeVC: UIViewController {

    // MARK: - Properties
    var webView: WKWebView?
    let indicator = UIActivityIndicatorView(style: .medium)
    var address = ""
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.configureUI()
        }
    }
    
    // MARK: - UI
    private func configureUI() {
        view.backgroundColor = .white
        setAttributes()
        setContraints()
    }
    
    private func setAttributes() {
            let contentController = WKUserContentController()
            contentController.add(self, name: "callBackHandler")

            let configuration = WKWebViewConfiguration()
                configuration.userContentController = contentController
                
                self.webView = WKWebView(frame: .zero, configuration: configuration)
                self.webView?.navigationDelegate = self

                guard let url = URL(string: "https://yaewonlee.github.io/Kakao-Postcode/"),
                      let webView = self.webView
                    else { return }
                let request = URLRequest(url: url)
                webView.load(request)
            self.indicator.startAnimating()
        }
    
    private func setContraints() {
        guard let webView = webView else { return }
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false

        webView.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            indicator.centerXAnchor.constraint(equalTo: webView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: webView.centerYAnchor)
        ])
    }
}


extension PostcodeVC: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if let data = message.body as? [String: Any] {
                DispatchQueue.main.async {
                    self.address = data["roadAddress"] as? String ?? ""
                    print(self.address)
                    
//                    guard let previousVC = self.presentingViewController as? AddPlaceVC else { return }
//                    print(previousVC.roadAddress.text)
//                    previousVC.roadAddress.text = "hi"
                    print("도로명주소 넘겨주기")
                }
            }
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension PostcodeVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicator.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
}
