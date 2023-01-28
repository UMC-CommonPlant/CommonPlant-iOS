//
//  kakaoLogin.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/28.
//

import Foundation
struct kakaoLogin:Decodable{
    let id: Int
    let connected_at: String
    let properties: [String]
    let kakao_account: [String]
    
}
