//
//  LoginViewController.swift
//  CommonPlant_iOS
//
//  Created by 다현 on 2023/01/16.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import Alamofire


class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //========== kakao login button==========
    @IBAction func kakaoLoginAction(_ sender: UIButton){
        kakaoLogin()
    }
}


extension LoginViewController{
    func kakaoLogin(){
        print("kakao Login")
        //카카오 계정으로 로그인할 때
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                guard let accessToken = oauthToken?.accessToken else {
                    return
                }
                //accessToken
                print(accessToken)
                self.checkLogin(accessToken : accessToken ?? "", loginForm: "kakao")
                }
                
            }
        }
    
    
    func checkLogin(accessToken: String, loginForm: String){
        //accessToken으로 kakao 유저 데이터 가져오기
        let url = API.BASE_URL + "/users/login/kakao"
        let header : HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        let queryString : Parameters = ["accessToken" : accessToken]
        
        MyAlamofireManager.shared
            .session
            .request(url,method : .post, parameters: queryString, encoding: URLEncoding.queryString)
            .responseJSON(completionHandler: {response in
                
                switch response.result{
                case .success(let obj):
                    //로그인 성공시 200 메시지 -> success
                    //로그인 성공시 userDefault에 token을 저장한 후 Main 화면으로 넘어가야 함
                    print(loginForm)
                    do{
                        let dataJson = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        let jsonData = try JSONDecoder().decode(APIResult.self, from: dataJson)
                        
                        var userToken: String! = jsonData.result ?? ""
                        UserDefaults.standard.set(userToken!, forKey: "token")
                        //가져다쓰기~~
                        var token = UserDefaults.standard.object(forKey: "token") as! String ?? ""
                    }catch{
                        print("error")
                    }
                    
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    guard let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController  else { return }
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                    
                    break
                case .failure(let err):
                    //email과 함께 회원가입 화면으로 넘어가야함
                    switch loginForm{
                    case "kakao":
                        print("kakaoLogin")
//                        guard self.getEmailByKakao(accessToken: accessToken) != nil else { return }
                        self.getEmailByKakao(accessToken: accessToken)
                        break
                    case "naver":
                        print("naverLogin")
                        break
                    default:
                        print("다른 플랫폼임")
                        break
                    }
                    let storyboard = UIStoryboard(name: "Login", bundle: nil)
                    guard let vc = storyboard.instantiateViewController(withIdentifier: "JoinView") as? NicknameViewController  else { return }
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                    break
                }
                
            })
        
    }
    
    //MARK: 회원가입 화면으로 넘어가기
    func getEmailByKakao(accessToken: String){
        let url = "https://kapi.kakao.com/v2/user/me"
        let request = AF.request(url,
                                 method: .get,
                                 parameters: nil,
                                 encoding: JSONEncoding.default,
                                 headers: ["Content-Type":"application/x-www-form-urlencoded;charset=utf-8", "Authorization":"Bearer "+accessToken])
            .validate(statusCode: 200..<300) //요청에 대한 유효성 검사 200<=300 상태만 허용
            .responseJSON { (response) in
                switch response.result{
                case .success(let obj):
                    do{
                        let dataJson = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
//                        let jsonData = try JSONDecoder().decode(kakaoLogin.self, from: dataJson)
//                        let email: String = jsonData.properties.Account.email as! String
                        print("kakaologin success ===============")
//                        print(email)
//                        return email
                        return
                    }catch{
                        print(error.localizedDescription)
                        return
                    }
                default : return
                }
            }
    }
}
