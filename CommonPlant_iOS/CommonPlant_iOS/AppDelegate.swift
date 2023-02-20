//
//  AppDelegate.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/01/10.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import NaverThirdPartyLogin


@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
//        KakaoSDK.initSDK(appKey: kakaoAppKey as! String, loggingEnable:false)
//        return true
//        KakaoSDKCommon.initSDK(appKey: "740ee7bf595c5acfcbf21ce506160841")

        KakaoSDK.initSDK(appKey: "740ee7bf595c5acfcbf21ce506160841")
        
        //네이버로그인
        let connection = NaverThirdPartyLoginConnection.getSharedInstance()
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
        // 네이버 앱으로 인증하는 방식 활성화
        instance?.isNaverAppOauthEnable = true
        // SafariViewController에서 인증하는 방식 활성화
        instance?.isInAppOauthEnable = true
        // 인증 화면을 아이폰의 세로모드에서만 적용
        instance?.isOnlyPortraitSupportedInIphone()
        instance?.serviceUrlScheme = "naverlogin" // 네아로에 등록한 scheme
        instance?.consumerKey = "0_o3yhDUpM2tpgB6zYAn" // 네아로 설정파일에 키
        instance?.consumerSecret = "fSZy__rDto" // 네아로 설정파일에 비번
        instance?.appName = "커먼플랜트" // 네아로에 등록한 앱 이름
        
        
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        NaverThirdPartyLoginConnection.getSharedInstance().isInAppOauthEnable = true
                NaverThirdPartyLoginConnection.getSharedInstance().isNaverAppOauthEnable = true
        
        
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                return AuthController.handleOpenUrl(url: url)
            }

            return false
        }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

