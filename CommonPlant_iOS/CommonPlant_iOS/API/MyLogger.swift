//
//  MyLogger.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/02/07.
//

import Foundation
import Alamofire

//log설정
final class MyLogger: EventMonitor{
    let queue = DispatchQueue(label: "MyLogger")
    
    func requestDidResume(_ request: Request){
        print("MyLogger - requestDidResume()")
        debugPrint(request)
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>){
        print("========== debugPrint ===========")
        print("MyLogger - request.didParseResponse()")
        debugPrint(response)
    }
}
