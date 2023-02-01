//
//  InfoDetail.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/29.
//

import Foundation

struct InfoDetailModel: Codable{
    let timeStamp: String
    let status: String
    let message: String
//    let result: setData?
    let success: Bool
}

//struct setData: Codable{
//    let name: String?
//    let humidity: String
//    let management: String
//    let place: String
//    let scientific_name: String
//    let water_day: Int
//    let sunlight: String
//    let temp_max: Int
//    let temp_min: Int
//    let tip: String
////    let waterSpring: String
////    enum CodingKeys: String, CodingKeys{
////        case waterSpring = "water_spring"
////    }
////
//}
