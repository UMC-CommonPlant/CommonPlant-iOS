//
//  InfoPopularSearchModel.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/02/13.
//

import Foundation

// MARK: - InfoPopularSearchModel
struct InfoPopularSearchModel: Codable {
    let timeStamp: String
    let status: Int
    let message: String
    let result: [infoPopular]
    let success: Bool
}

// MARK: - Result
struct infoPopular: Codable {
    let name: String
    let searchedNumber: Int
    let imgURL: String
    let scientificName: String

    enum CodingKeys: String, CodingKey {
        case name, searchedNumber
        case imgURL = "imgUrl"
        case scientificName = "scientific_name"
    }
}
