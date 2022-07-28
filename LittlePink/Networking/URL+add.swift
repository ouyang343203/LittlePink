//
//  URL+add.swift
//  Ukaku
//
//  Created by pyx on 2022/2/28.
//

import Moya

//解决，URL 中带有? 号被转义成 %3f 的问题
public extension URL {
    
    init<T: TargetType>(t target: T) {
           if target.path.isEmpty {
               self = target.baseURL
           } else if target.path.contains("?") {
               // 这里直接强制解包了，这里可以修改，如果你需要。
               // 这里直接强制解包了，这里可以修改，如果你需要。
               if let url = URL.init(string: target.baseURL.absoluteString + target.path) {
                   self = url
               }else {
                   self = URL.init(string: target.baseURL.absoluteString)!
               }
           } else {
               self = target.baseURL.appendingPathComponent(target.path)
           }
       }
    
}




public extension MoyaProvider {
    
    
    final class func pqEndpointMapping(for target: Target) -> Endpoint {
       return Endpoint(
           url: URL(t: target).absoluteString,
           sampleResponseClosure: { .networkResponse(200, target.sampleData) },
           method: target.method,
           task: target.task,
           httpHeaderFields: target.headers
       )
   }
    
}
