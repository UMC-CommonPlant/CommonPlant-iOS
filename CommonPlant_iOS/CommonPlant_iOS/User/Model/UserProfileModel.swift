//
//  UserProfileModel.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/02/15.
//

import Foundation
// MARK: - UserProfileModel
struct UserProfileModel: Codable {
    let timeStamp: String
    let status: Int
    let message: String
    let result: UserProfile
    let success: Bool
}

// MARK: - Result
struct UserProfile: Codable {
    let nickName, email, platform: String
    let userImgURL: String

    enum CodingKeys: String, CodingKey {
        case nickName, email, platform
        case userImgURL = "userImgUrl"
    }
}
