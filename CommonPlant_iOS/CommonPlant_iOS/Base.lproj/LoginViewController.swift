//
//  LoginViewController.swift
//  CommonPlant_iOS
//
//  Created by 다현 on 2023/01/16.
//

import UIKit
import Foundation
import NaverThirdPartyLogin
import KakaoSDKAuth
import KakaoSDKUser
import Alamofire


class LoginViewController: UIViewController {
    
    let connection = NaverThirdPartyLoginConnection.getSharedInstance()
    let instance = NaverThirdPartyLoginConnection.getSharedInstance()
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginInstance?.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    //========== kakao login button==========
    @IBAction func kakaoLoginAction(_ sender: UIButton){
        kakaoLogin()
    }
    
    //네이버 로그인
    @IBAction func naverLoginAction(_ sender: UIButton) {
        loginInstance?.requestThirdPartyLogin()
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
extension LoginViewController: NaverThirdPartyLoginConnectionDelegate{

    
    // RESTful API, id가져오기
      func getInfo() {
        guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        
        if !isValidAccessToken {
          return
        }
        
        guard let tokenType = loginInstance?.tokenType else { return }
        guard let accessToken = loginInstance?.accessToken else { return }
          
        let urlStr = "https://openapi.naver.com/v1/nid/me"
        let url = URL(string: urlStr)!
        
        let authorization = "\(tokenType) \(accessToken)"
        
        let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
        
        req.responseJSON { response in
          guard let result = response.value as? [String: Any] else { return }
          guard let object = result["response"] as? [String: Any] else { return }
          guard let name = object["name"] as? String else { return }
          guard let email = object["email"] as? String else { return }
          guard let id = object["id"] as? String else {return}
            print("================naver login ================")
          print(email)
//          self.nameLabel.text = "\(name)"
//          self.emailLabel.text = "\(email)"
//          self.id.text = "\(id)"
        }
      }
      // 로그인에 성공한 경우 호출
      func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
          print("Success login")
          getInfo()
      }
      // referesh token
      func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
          loginInstance?.accessToken
      }
      // 로그아웃
      func oauth20ConnectionDidFinishDeleteToken() {
          print("log out")
      }
      // 모든 error
      func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
          print("error = \(error.localizedDescription)")
      }
}
