// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let myPlantModel = try? JSONDecoder().decode(MyPlantModel.self, from: jsonData)

import Foundation

struct MyPlantModel: Codable {
    let timeStamp: String
    let status: Int
    let message: String
    let result: MyPlantResult
    let success: Bool
}

struct MyPlantResult: Codable {
    let plant: Plant
    let memoList: MemoList
}

struct MemoList: Codable {
    let memoCardDto: [[MemoCardDto]?]
}

struct MemoCardDto: Codable {
    let memoIdx, plantIdx: Int
    let userNickName: String
    let userImgURL: String?
    let content: String
    let imgUrl: String?
    let createdAt: String
}

struct Plant: Codable {
    let plantIdx: Int
    let name, nickname, place: String
    let imgUrl: String?
    let countDate, remainderDate: Int
    let scientificName: String
    let waterDay: Int
    let sunlight: String
    let tempMin, tempMax: Int
    let humidity, createdAt, wateredDate: String
}
