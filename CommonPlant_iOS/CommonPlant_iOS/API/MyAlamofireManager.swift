//
//  MyAlamofireManager.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/02/07.
//

import Foundation
import Alamofire

final class MyAlamofireManager{
    //싱글톤 적용
    static let shared = MyAlamofireManager()
    
    //인터셉터 -> API호출시 중간에 가로채서 공통 파라미터를 넣음, 토큰 인증 등에 사용
    let interceptors = Interceptor(interceptors:
                        [
                            BaseInterceptor()
                        ])
    
    //로거 설정(이벤트 화면)
    let monitors = [MyLogger(), MyApiStatusLogger()] as [EventMonitor]
    
    //세션
    var session: Session
    
    private init(){
        session = Session(
            interceptor: interceptors,
            eventMonitors: monitors
        )
    }
}
