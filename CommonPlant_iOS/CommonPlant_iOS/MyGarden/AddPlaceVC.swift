//
//  AddPlaceViewController.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/02/02.
//

import UIKit

class AddPlaceVC: UIViewController, SendDataDelegate {
    func sendData(address: String) {
        roadAddress.text = address
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var roadAddress: UILabel!
    @IBOutlet weak var addressBtn: UIButton!
 //   var road: String?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
   //     roadAddress.text = road
        configureUI()
    }
    
    // MARK: - UI
    private func configureUI() {
        addressBtn.addTarget(self, action: #selector(handleButton(_:)), for: .touchUpInside)
        navigationController?.isNavigationBarHidden = false
        textFieldUnderline()
        buttonUnderLine()
    }
    
    func textFieldUnderline() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 1, width: textField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor(named: "Gray2")?.cgColor
        textField.borderStyle = UITextField.BorderStyle.none
        textField.layer.addSublayer(bottomLine)
    }
    
    func buttonUnderLine() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: addressBtn.frame.height - 1, width: addressBtn.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor(named: "Gray2")?.cgColor
        addressBtn.layer.addSublayer(bottomLine)
    }
    
    // MARK: - Selectors
    @objc
    private func handleButton(_ sender: UIButton) {
       let nextVC = PostcodeVC()
        nextVC.delegate = self
        present(nextVC, animated: true)
    }
}
