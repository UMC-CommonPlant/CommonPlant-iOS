//
//  NicknameViewController.swift
//  CommonPlant_iOS
//
//  Created by 다현 on 2023/01/17.
//

import UIKit
import Photos

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.nickNameField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func alertBtn(_ sender: Any) {
        actionSheetAlert()
    }
    
    

    var imageNM = ["checkmark.circle.fill","checkmark.circle"]
    
    
    @IBAction func nextTermsCheckBtn(_ sender: Any) {
//        print("clicked")
//
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
        
        let alert = UIAlertController(title: "선택", message: "선택", preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let camera = UIAlertAction(title: "카메라", style: .default) { [weak self] (_) in
            self?.presentCamera()
        }
        let album = UIAlertAction(title: "앨범", style: .default) { [weak self] (_) in
            self?.presentAlbum()
        }
        
        alert.addAction(cancel)
        alert.addAction(camera)
        alert.addAction(album)
        
        present(alert, animated: true, completion: nil)
        
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

