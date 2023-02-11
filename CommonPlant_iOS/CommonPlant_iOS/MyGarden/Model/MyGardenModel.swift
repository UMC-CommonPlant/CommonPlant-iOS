//
//  MyGardenModel.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/01/20.
//

import Foundation

struct MyPlaceModel: Codable {
    let timeStamp: String
    let status: Int
    let message: String
    let result: MyPlaceResult
    let success: Bool
}

struct MyPlaceResult: Codable {
    let name, address, highestTemp, minimumTemp: String
    let humidity: String
    let isOwner: Bool
    let userInfoList: [UserInfoList]
    let plantInfoList: [PlantInfoList]
}

struct PlantInfoList: Codable {
    let name, nickname: String
    let imgURL: String
    let recentMemo: String
    let remainderDate: Int
    let wateredDate: String
}

struct UserInfoList: Codable {
    let nickName: String
    let owner: Bool
    let imgURL: String
}
