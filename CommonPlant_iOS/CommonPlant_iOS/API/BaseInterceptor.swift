//
//  BaseInterceptor.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/02/07.
//

import Foundation
import Alamofire

class BaseInterceptor: RequestInterceptor{
    //API 호출시 request할 떄 들어가는 부분
    func adapt(_ urlRequest: URLRequest, for: Session, completion: (Result<URLRequest, Error>) -> Void){
        
        print("BaseInterceptor - adapt")
        var request = urlRequest
        request.addValue("application/json; charset=UTF-8 ", forHTTPHeaderField: "Content-Type")
        completion(.success(request))
    }
    
    func retry(_ request: Request, for: Session, dueTo: Error, completion: (RetryResult) -> Void){
        print("BaseInterceptor - retry")
        completion(.doNotRetry)
    }
}
