//
//  LoginViewController.swift
//  CommonPlant_iOS
//
//  Created by 다현 on 2023/01/16.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //카카오 계정으로 로그인 시 -> 로그인 API 호출
    //join : 사용자 정보와 함께 "1-2-2 Login" 으로 넘어감 -> 사용자 정보와 함께 join -> userDefault에 jwt token 저장 후 "Main"으로 넘어감
    //login : userDefault에 jwt token 저장 후 "Main"으로 넘어감
    @IBAction func kakaoLoginAction(_ sender: UIButton){
        print("kakao Login")
        //앱에 카카오톡이 설치되어 있는지 확인
        if(UserApi.isKakaoTalkLoginAvailable()){
            //카카오톡으로 로그인(권장)
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("loginWithKakaoTalk() success.")

                        //do something
                        _ = oauthToken
                    }
                }
        }else{
            //카카오 계정으로 로그인할 때
            print("계정으로 로그인")
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
                }
            }
        }
        
       
    }
    
    
    
    
    
    @IBAction func setnickname(_ sender: Any) {
        //로그인 화면의 storyboard ID를 참조하여 뷰 컨트롤러를 가져오기
        guard let toset = self.storyboard?.instantiateViewController(withIdentifier: "NicknameView") else {
            return
        }
        //화면 전환 애니메이션을 설정
        toset.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        
        //인자값으로 다음 뷰 컨트롤러를 넣고 present 메소드를 호출
        self.present(toset, animated: true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
