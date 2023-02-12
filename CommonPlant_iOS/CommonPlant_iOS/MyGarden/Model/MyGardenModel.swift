//
//  MyGardenModel.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/02/11.
//

import Foundation

struct MyGardenModel: Codable {
    let timeStamp: String
    let status: Int
    let message: String
    let result: MyGardenResult
    let success: Bool
}

struct MyGardenResult: Codable {
    let nickName: String
    let placeList: [PlaceList]
    let plantList: [PlantList]
}

struct PlaceList: Codable {
    let placeCode, placeName: String
    let countUser, countPlant: Int
    let imgURL: String?
}

struct PlantList: Codable {
    let plantIdx: Int
    let plantNickName, placeCode: String
    let countUserOfPlace, remainderDate: Int
    let imgURL: String?
}
