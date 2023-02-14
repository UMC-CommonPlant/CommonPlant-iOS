//
//  MyPlantModel.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/02/11.
//

import Foundation

struct MyPlantModel: Codable {
    let timeStamp: String
    let status: Int
    let message: String
    let result: MyPlantResult
    let success: Bool
}

struct MyPlantResult: Codable {
    let name, address, highestTemp, minimumTemp: String
    let humidity: String
    let isOwner: Bool
    let userInfoList: [MyPlaceUserInfoList]
    let plantInfoList: [MyPlantInfoList]
}

struct MyPlantInfoList: Codable {
    let name, nickname: String
    let imgUrl: String
    let recentMemo: String?
    let remainderDate: Int
    let wateredDate: String
}

struct MyPlaceUserInfoList: Codable {
    let nickName: String
    let owner: Bool
    let imgUrl: String
}
