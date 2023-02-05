//
//  InfoSearchModel.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/02/05.
//

import Foundation

struct InfoSearchModel: Codable{
    let timeStamp: String
    let status: String
    let message: String
    let result: [result]
    let success: Bool
}
struct result: Codable{
    let name: String
    let imgUrl: String
//    "scientific_name": String
}
