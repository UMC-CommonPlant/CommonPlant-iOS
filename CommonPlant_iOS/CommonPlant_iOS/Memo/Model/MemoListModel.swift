////
////  MemoListModel.swift
////  CommonPlant_iOS
////
////  Created by hweyoung on 2023/02/12.
////
//
//import Foundation
//
//// MARK: - MemoListModel
struct MemoListModel: Codable {
    let timeStamp: String
    let status: Int
    let message: String
    let result: MemoRes
    let success: Bool
}

struct MemoRes: Codable {
    let memoCardDto: [[MemoDto]]
}

struct MemoDto: Codable {
    let memoIdx, plantIdx: Int
    let userNickName: String
    let userImgURL: String
    let content: String
    let imgURL: String?
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case memoIdx, plantIdx, userNickName
        case userImgURL = "userImgUrl"
        case content
        case imgURL = "imgUrl"
        case createdAt
    }
}

