//
//  MyApiStatus.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/02/07.
//

import Foundation
import Alamofire

final class MyApiStatusLogger: EventMonitor{
    let queue = DispatchQueue(label: "MyApiStatusLogger")

    //status만 설정
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>){
        guard let statusCode = request.response?.statusCode else { return }
        print("MyApiStatusLogger - statusCode : \(statusCode)")
    }
}
