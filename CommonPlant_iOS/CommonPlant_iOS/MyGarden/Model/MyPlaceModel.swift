// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let myPlaceModel = try? JSONDecoder().decode(MyPlaceModel.self, from: jsonData)

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
    let imgUrl: String
    let recentMemo: String?
    let remainderDate: Int
    let wateredDate: String
}

struct UserInfoList: Codable {
    let nickName: String
    let owner: Bool
    let imgUrl: String
}
