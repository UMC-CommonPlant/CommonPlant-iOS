//
//  AddPlant2ndViewController.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/02/11.
//

import UIKit
import Alamofire

class AddPlant2ndVC: UIViewController {
    
    @IBOutlet weak var selectPlaceBtn: UIButton!
    @IBOutlet weak var placeCollectionView: UICollectionView!
    @IBOutlet weak var selectDateBtn: UIButton!
    @IBOutlet weak var calendar: UIDatePicker!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var plantNameLabel: UILabel!
    @IBOutlet weak var addPlantDefaultImg: UIImageView!
    @IBOutlet weak var addPlantImgBtn: UIButton!
    var cnt = 0

    var plantImage = UIImage(named: "addPlace1stImg")
    var plantName: String = ""
    var plantNickname: String = ""
    var waterDate: String = ""
    var placeCode: String = ""
    
    @IBAction func registerBtn(_ sender: Any) {
        addPlantData(name: plantName, nickname: plantNickname, place: placeCode, waterDate: waterDate, image: plantImage!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeCollectionView.delegate = self
        placeCollectionView.dataSource = self
    }

}

extension AddPlant2ndVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func actionSheetAlert() {
        let alert = UIAlertController(title: "식물 사진 설정", message: nil, preferredStyle: .actionSheet)
        
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
        addPlantDefaultImg.image = UIImage(named: "addPlantBasic")
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
                addPlantDefaultImg.image = image
                plantImage = image
            }
        } else {
            if let image = info[.originalImage] as? UIImage {
                addPlantDefaultImg.image = image
                plantImage = image
            }
        }
        cnt += 1
        
        dismiss(animated: true, completion: nil )
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension AddPlant2ndVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = placeCollectionView.dequeueReusableCell(withReuseIdentifier: "AddPlant2ndCVC", for: indexPath) as? AddPlant2ndCVC else { return UICollectionViewCell() }
        
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 156)
    }
}

extension AddPlant2ndVC {
    func addPlantData(name: String, nickname: String, place: String, waterDate: String, image: UIImage){
           let url = API.BASE_URL + "/plant/add"
           let token = UserDefaults.standard.object(forKey: "token") as! String

           let header : HTTPHeaders = [
               "Content-Type" : "multipart/form-data",
               "X-AUTH-TOKEN" : token
           ]
           
           let parameters: [String: Any] = [
               "name" : name,
               "nickname" : nickname,
               "place" : place,
               "wateredDate" : waterDate
           ]
           
           AF.upload(multipartFormData: { MultipartFormData in
               for (key, value) in parameters {
                   MultipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
               }
               if let image = image.pngData() {
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
