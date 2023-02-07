//
//  InfoSearchModel.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/02/05.
//

import Foundation

// MARK: - InfoSearchModel
struct InfoSearchModel: Codable {
    let timeStamp: String
    let status: Int
    let message: String
    let result: [InfoRes]
    let success: Bool
}

// MARK: - Result
struct InfoRes: Codable {
    let name: String
    let imgURL: String
    let scientificName: String

    enum CodingKeys: String, CodingKey {
        case name
        case imgURL = "imgUrl"
        case scientificName = "scientific_name"
    }
}
