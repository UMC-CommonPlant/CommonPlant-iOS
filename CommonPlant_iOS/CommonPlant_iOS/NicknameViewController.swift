//
//  NicknameViewController.swift
//  CommonPlant_iOS
//
//  Created by 다현 on 2023/01/17.
//

import UIKit
import Photos
import Alamofire

class NicknameViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var textCountLabel: UILabel!
    
    @IBOutlet weak var nickNameField: UITextField!
    
    
    @IBOutlet weak var nextTermsButton: UIButton!
    @IBOutlet weak var nextTermsDoneButton: UIButton!
    
    var textToEmail: String?
    var textToLoginPlatform: String?
    
    var cnt = 0
    
    var TBtn: Bool = false
    
    
    @IBAction func testButtonAction(_ sender: Any) {
//        addPlaceAPI()
//        addPlantAPI()
//        joinUserAPI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.nickNameField.delegate = self
    }
    
    
    
    
    
    @IBAction func alertBtn(_ sender: Any) {
        actionSheetAlert()
    }
    
    
    
    var imageNM = ["checkmark.circle.fill","checkmark.circle"]
    
    
    @IBAction func nextTermsCheckBtn(_ sender: Any) {
        print("clicked")
        
        //        if TBtn == false {
        //            nextTermsButton.setImage(UIImage(systemName: imageNM[0]), for: .normal)
        //            TBtn = true
        //            nextTermsDoneButton.backgroundColor = UIColor.blue
        //            print("true")
        //        }else {
        //            nextTermsButton.setImage(UIImage(systemName: imageNM[1]), for: .normal)
        //            TBtn = false
        //            nextTermsDoneButton.backgroundColor = UIColor.gray
        //            print("false")
        //        }
        
    }
    
    
    @IBAction func goagree(_ sender: Any) {
        //로그인 화면의 storyboard ID를 참조하여 뷰 컨트롤러를 가져오기
        guard let agree = self.storyboard?.instantiateViewController(withIdentifier: "AgreeView") else {
            return
        }
        //화면 전환 애니메이션을 설정
        agree.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        
        //인자값으로 다음 뷰 컨트롤러를 넣고 present 메소드를 호출
        self.present(agree, animated: true)
    }
    
    
    
}
//MARK: nickNameText
extension NicknameViewController: UITextFieldDelegate{
    
    //MARK: text count label
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("textField")
        let currentText = nickNameField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        textCountLabel.text = "\(updatedText.count)"
        return updatedText.count < 10
    }
}

//MARK: =========카메라 선택==========
// UIImagePickerControllerDelegate = 카메라 롤이나 앨범에서 사진을 가져올 수 있도록 도와 주는 것
extension NicknameViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    func actionSheetAlert(){
        
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
        print("기본이미지 넣기!!!!!! 화면에 띄워주기~~~~~")
//        addPlace1stImg.image = UIImage(named: "plant1")
    }
    
    func presentCamera(){
        
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        vc.cameraFlashMode = .on
        
        present(vc, animated: true, completion: nil)
    }
    
    func presentAlbum(){
        
        
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        
        present(vc, animated: true, completion: nil)
    }
    
    
    //카메라나 앨범등 PickerController가 사용되고 이미지 촬영을 했을 때 발동 된다.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("picker -> \(String(describing: info[UIImagePickerController.InfoKey.imageURL]))")
        
        if cnt % 2 == 0 {
            
            if let image = info[.editedImage] as? UIImage {
                profileImage.image = image
            }
            
        }
        else{
            
            if let image = info[.originalImage] as? UIImage {
                profileImage.image = image
            }
            
        }
        
        cnt += 1
        
        print(cnt)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
extension NicknameViewController{

    func addMemoAPI(){
        //accessToken으로 kakao 유저 데이터 가져오기
        let url = API.BASE_URL + "/memo/add/17"//+plantIdx
        var token = UserDefaults.standard.object(forKey: "token") as! String ?? ""

        let header : HTTPHeaders = [
            "Content-Type" : "multipart/form-data",
            "X-AUTH-TOKEN" : token
        ]
        let image = UIImage(named: "plant1")
        profileImage.image = UIImage(named: "plant1")
        
        let parameters: [String: Any] = [
            "content" : "장마여서 물 주는 날짜를 조금 늦춤, 하지만 해는 맑구나 몬테랑 함께한 지 벌써 56일이 되었구나 요즘 잎이 갈라지니 채광이 더 드는 곳으로 자리를 옮겨야 할 것 같아"
        ]
        
        AF.upload(multipartFormData: { MultipartFormData in
            //body 추가
            for (key, value) in parameters {
                MultipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
            //img 추가
            if let image = image?.pngData() {
                MultipartFormData.append(image, withName: "image", fileName: "test.png", mimeType: "image/png")
            }
        }, to: url, method: .post, headers: header)
        .response{ response in
            if let error = response.error{
                print(error)
            }else{
                debugPrint(response)
            }
        }
        
    }
    func joinUserAPI(email: String, nickname: String, loginType: String){
        //accessToken으로 kakao 유저 데이터 가져오기
        let url = API.BASE_URL + "/users/join"

        let header : HTTPHeaders = [
            "Content-Type" : "multipart/form-data",
        ]
        let image = UIImage(named: "plant1")
        profileImage.image = UIImage(named: "plant1")
        
        let parameters: [String: Any] = [
            "email":email,
            "nickName":nickname,
            "loginType":loginType
        ]
        
        AF.upload(multipartFormData: { MultipartFormData in
            //body 추가
            for (key, value) in parameters {
                MultipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
            //img 추가
            if let image = image?.pngData() {
                MultipartFormData.append(image, withName: "image", fileName: "test.png", mimeType: "image/png")
            }
        }, to: url, method: .post, headers: header)
        .response{ response in
            if let error = response.error{
                print(error)
            }else{
                debugPrint(response)
            }
        }
        
    }
}

