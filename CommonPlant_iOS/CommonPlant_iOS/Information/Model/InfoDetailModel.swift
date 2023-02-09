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
    let result: res
    let success: Bool
}

// MARK: - Result
struct res: Codable {
    let name, humidity, management, place: String
    let scientificName: String
    let waterDay: Int
    let sunlight: String
    let tempMax, tempMin: Int
    let tip, waterSpring, waterAutumn, waterWinter: String
    let waterSummer: String
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
        case waterSpring = "water_spring"
        case waterAutumn = "water_autumn"
        case waterWinter = "water_winter"
        case waterSummer = "water_summer"
        case imgURL = "imgUrl"
        case createdAt = "created_at"
    }
}

// MARK: - CreatedAt
struct CreatedAt: Codable {
    let seconds, nanos: Int
}

