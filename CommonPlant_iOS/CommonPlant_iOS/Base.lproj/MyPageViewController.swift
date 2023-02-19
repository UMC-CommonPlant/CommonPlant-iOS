//
//  MyPageViewController.swift
//  CommonPlant_iOS
//
//  Created by 다현 on 2023/01/16.
//

import UIKit
import Alamofire

class MyPageViewController: UIViewController {

    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myProfileAPI()
        // Do any additional setup after loading the view.
    }
}
extension MyPageViewController{
    func myProfileAPI(){
        
        var token = UserDefaults.standard.object(forKey: "token") as! String ?? ""

        //accessToken으로 kakao 유저 데이터 가져오기
        let url = API.BASE_URL + "/users/myProfile"
        
        let header : HTTPHeaders = [
//            "Content-Type" : "application/json",
            "X-AUTH-TOKEN": token
        ]
//        let queryString : Parameters = ["name" : name]
        
        MyAlamofireManager.shared
            .session
            .request(url,method : .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseJSON(completionHandler: {response in
                        
                        switch response.result{
                            
                            
                        case .success(let obj):
                            print("========== 테스트ㅡ으으으 ===========")
                            do{
                                let dataJson = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                                let jsonData = try JSONDecoder().decode(UserProfileModel.self, from: dataJson)
                                print(jsonData)
                             
                                let url = URL(string: jsonData.result.userImgURL)
                                
                                self.userImageView.kf.setImage(with: url)
                                self.userImageView.layer.cornerRadius = self.userImageView.frame.height/2

                                self.nameLabel.text = jsonData.result.nickName
                                self.emailLabel.text = jsonData.result.email
                                
                            }catch{
                                print(error.localizedDescription)
                            }
                        
                            break
                        case .failure(let err):
                            debugPrint(err)
                            break
                        }
                    })
            }
}
