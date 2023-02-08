//
//  kakaoLogin.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/28.
//

import Foundation

// MARK: - KakaoLogin
struct KakaoLogin: Codable {
    let id: Int
    let connectedAt: Date
    let properties: Properties
    let kakaoAccount: KakaoAccount

    enum CodingKeys: String, CodingKey {
        case id
        case connectedAt = "connected_at"
        case properties
        case kakaoAccount = "kakao_account"
    }
}

// MARK: - KakaoAccount
struct KakaoAccount: Codable {
    let profileNicknameNeedsAgreement, profileImageNeedsAgreement: Bool
    let profile: Profile
    let hasEmail, emailNeedsAgreement, isEmailValid, isEmailVerified: Bool
    let email: String
    let hasAgeRange, ageRangeNeedsAgreement: Bool
    let ageRange: String
    let hasGender, genderNeedsAgreement: Bool
    let gender: String

    enum CodingKeys: String, CodingKey {
        case profileNicknameNeedsAgreement = "profile_nickname_needs_agreement"
        case profileImageNeedsAgreement = "profile_image_needs_agreement"
        case profile
        case hasEmail = "has_email"
        case emailNeedsAgreement = "email_needs_agreement"
        case isEmailValid = "is_email_valid"
        case isEmailVerified = "is_email_verified"
        case email
        case hasAgeRange = "has_age_range"
        case ageRangeNeedsAgreement = "age_range_needs_agreement"
        case ageRange = "age_range"
        case hasGender = "has_gender"
        case genderNeedsAgreement = "gender_needs_agreement"
        case gender
    }
}

// MARK: - Profile
struct Profile: Codable {
    let nickname: String
    let thumbnailImageURL, profileImageURL: String
    let isDefaultImage: Bool

    enum CodingKeys: String, CodingKey {
        case nickname
        case thumbnailImageURL = "thumbnail_image_url"
        case profileImageURL = "profile_image_url"
        case isDefaultImage = "is_default_image"
    }
}

// MARK: - Properties
struct Properties: Codable {
    let nickname: String
    let profileImage, thumbnailImage: String

    enum CodingKeys: String, CodingKey {
        case nickname
        case profileImage = "profile_image"
        case thumbnailImage = "thumbnail_image"
    }
}
