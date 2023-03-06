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
    @IBOutlet weak var nextButton: UIButton!
    
    
    var placeImage = UIImage(named: "addPlace1stImg")
    var placeName: String = ""
    var addressRoad: String = ""
    var cnt = 0
    var placeCode = ""
    
    @IBAction func nextBtn(_ sender: Any) {
        print(#function)
        placeName = textField.text ?? ""
        uploadData(name: placeName, address: addressRoad, imageData: placeImage!) { response in
            self.placeCode = response.result
            print("*******placeCode?? \(self.placeCode)************")
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyPlaceViewController") as? MyPlaceVC else { return }
            vc.myPlaceCode = self.placeCode
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func addPlaceImgBtn(_ sender: Any) {
        actionSheetAlert()
    }
    
    
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
        addressBtn.addTarget(self, action: #selector(addressButton(_:)), for: .touchUpInside)
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
    private func addressButton(_ sender: UIButton) {
        let nextVC = PostcodeVC()
        nextVC.modalPresentationStyle = .popover
        nextVC.delegate = self
        present(nextVC, animated: true)
    }
}

extension AddPlaceVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func actionSheetAlert() {
        let alert = UIAlertController(title: "장소 사진 설정", message: nil, preferredStyle: .actionSheet)
        
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
    func uploadData(name: String, address: String, imageData: UIImage, completion: @escaping (AddPlaceResult) -> Void) {
            let url = API.BASE_URL + "/place/add"
            let token = UserDefaults.standard.object(forKey: "token") as! String

            let header : HTTPHeaders = [
                "Content-Type" : "multipart/form-data",
                "X-AUTH-TOKEN" : token
            ]
            
            let parameters: [String: Any] = [
                "name" : name,
                "address" : address
            ]
            
            AF.upload(multipartFormData: { MultipartFormData in
                for (key, value) in parameters {
                    MultipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }
                if let image = imageData.pngData() {
                    MultipartFormData.append(image, withName: "image", fileName: "test.png", mimeType: "image/png")
                }
                
            }, to: url, method: .post, headers: header)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    print(data)
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)

                        let addPlaceData = try! JSONDecoder().decode(AddPlaceResult.self, from: jsonData)
                        completion(addPlaceData)
                        print("==========myPlaceCode: \(addPlaceData)========")
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(_):
                    break
                }
                
                if let error = response.error {
                    print(error)
                } else {
                    debugPrint(response)
                }
            }
            
        }
}
