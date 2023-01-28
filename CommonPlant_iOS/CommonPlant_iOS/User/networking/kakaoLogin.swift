//
//  kakaoLogin.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/28.
//

import Foundation
struct kakaoLogin: Codable{
    let id: Int
    let connected_at: String
    let properties: Properties
    let kakao_account: Account
    
}

struct Properties: Codable{
    let nickname: String
    let profile_image: String
    let thumbnail_image: String
}

struct Account: Codable{
    let profile: Profile
    let email: String
}

struct Profile: Codable{
    let nickname: String
    let profile_image_url: String
}


