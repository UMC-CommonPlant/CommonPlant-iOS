//
//  APIResult.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/02/08.
//

import Foundation
// MARK: - APIResult
struct APIResult: Codable {
    let timeStamp: String
    let status: Int
    let message, result: String
    let success: Bool
}
