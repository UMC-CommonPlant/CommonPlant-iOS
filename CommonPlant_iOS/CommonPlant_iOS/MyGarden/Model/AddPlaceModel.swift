//
//  AddPlaceModel.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/02/14.
//

import Foundation


struct AddPlaceResult: Codable {
    let timeStamp: String
    let status: Int
    let message: String
    let result: String
    let success: Bool
}
