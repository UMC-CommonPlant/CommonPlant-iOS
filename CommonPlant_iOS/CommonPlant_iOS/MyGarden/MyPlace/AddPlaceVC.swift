//
//  AddPlaceViewController.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/02/02.
//

import UIKit
import Alamofire


class AddPlaceVC: UIViewController, SendDataDelegate {
    func sendData(address: String) {
        roadAddress.text = address
        addressRoad = address
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var addressBtnImg: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var roadAddress: UILabel!
    @IBOutlet weak var addressBtn: UIButton!
    @IBOutlet weak var currentTextCount: UILabel!
    @IBOutlet weak var addPlace1stImg: UIImageView!
    
    var placeImage = UIImage(named: "addPlace1stImg")
    var placeName: String = ""
    var addressRoad: String = ""
    
    
    @IBAction func nextBtn(_ sender: Any) {
        print(#function)
        placeName = textField.text ?? ""
        uploadData(name: placeName, address: addressRoad, imageData: placeImage!) { response in
       
        }
        
      //  print("***********placeImage: \(placeImage) ****placeName: \(placeName), **** addressRoad:\(addressRoad)******")
    }
    
    
    @IBAction func addPlaceImgBtn(_ sender: Any) {
        actionSheetAlert()
    }
    
    var cnt = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let text = roadAddress.text, !text.isEmpty {
            addressBtnImg.image = UIImage(named: "InfoSearchCancel")
        }
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
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.delegate = self
        present(nextVC, animated: true)
    }
}

extension AddPlaceVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func actionSheetAlert() {
        let alert = UIAlertController(title: "프로필 사진 설정", message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        let album = UIAlertAction(title: "앨범에서 사진 선택", style: .default) { [weak self] (_) in
            self?.presentAlbum()
        }
        
        let defaultImg = UIAlertAction(title: "기본 이미지로 변경", style: .default) { [weak self] (_) in
            self?.setDefaultImg()
            
        }
        
        alert.addAction(cancel)
        alert.addAction(album)
        alert.addAction(defaultImg)
        
        present(alert, animated: true, completion: nil)
    }
    
    func setDefaultImg(){
        addPlace1stImg.image = UIImage(named: "addPlace1stImg")
    }
    
    func presentAlbum(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        
        present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("picker -> \(String(describing: info[UIImagePickerController.InfoKey.imageURL]))")
        if cnt % 2 == 0 {
            if let image = info[.editedImage] as? UIImage {
                addPlace1stImg.image = image
                placeImage = image
            }
        } else {
            if let image = info[.originalImage] as? UIImage {
                addPlace1stImg.image = image
                placeImage = image
            }
        }
        cnt += 1
        
        dismiss(animated: true, completion: nil )
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension AddPlaceVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        currentTextCount.text = "\(updatedText.count)"
        return updatedText.count < 10
    }
}

extension AddPlaceVC {
    func uploadData(name: String, address: String, imageData: UIImage, completion: @escaping ((Bool)-> Void)) {
        let accessToken: String = UserDefaults.standard.object(forKey: "token") as! String
        let url = API.BASE_URL + "/place/add"
        let header : HTTPHeaders = ["X-AUTH-TOKEN": accessToken]
        let parameters: [String: Any] = [
            "place":
                [
                    "name": name,
                    "address": address
                ]
        ]
        
        MyAlamofireManager.shared
            .session
            .upload(multipartFormData: { multipart in
                for (key, value) in parameters {
                    multipart.append("\(value)".data(using: .utf8)!, withName: key)
                }
                
                multipart.append((imageData.pngData())!, withName: "image", fileName: "image", mimeType: "image/png")
                
            }, to: url, headers: header)
            .responseJSON { response in
                guard let statusCode = response.response?.statusCode else { return }
                
                switch statusCode {
                case 200:
                    print("post 성공")
                    completion(true)
                default:
                    print(statusCode)
                    print("실패")
                }
            }
    }
}
