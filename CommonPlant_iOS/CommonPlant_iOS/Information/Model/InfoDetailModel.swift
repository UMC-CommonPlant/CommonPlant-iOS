//
//  InfoDetail.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/29.
//

import Foundation

// MARK: - InfoDetailModel
struct InfoDetailModel: Codable {
    let timeStamp: String
    let status: Int
    let message: String
    let result: InfoDetailRes
    let success: Bool
}

// MARK: - Result
struct InfoDetailRes: Codable {
    let name, humidity, management, place: String
    let scientificName: String
    let waterDay: Int
    let sunlight: String
    let tempMax, tempMin: Int
    let tip, waterType: String
    let month: Int
    let imgURL: String
    let createdAt: CreatedAt

    enum CodingKeys: String, CodingKey {
        case name, humidity, management, place
        case scientificName = "scientific_name"
        case waterDay = "water_day"
        case sunlight
        case tempMax = "temp_max"
        case tempMin = "temp_min"
        case tip
        case waterType = "water_type"
        case month
        case imgURL = "imgUrl"
        case createdAt = "created_at"
    }
}

// MARK: - CreatedAt
struct CreatedAt: Codable {
    let seconds, nanos: Int
}

