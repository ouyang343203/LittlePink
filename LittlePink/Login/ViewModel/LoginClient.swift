//
//  LoginClient.swift
//  LittlePink
//
//  Created by ouyang on 2022/7/18.
//

import Foundation
import Moya
import Alamofire
import HandyJSON

/// 回调 包括：网络请求的模型(code,message,data等，具体根据业务来定)
typealias RequestResultClosure = ((BaseModel) -> Void)
///先添加一个闭包用于成功时后台返回数据的回调
typealias successCallback = ((String) -> (Void))
typealias failureCallback = ((String) -> (Void))
/// 超时时长
private var requestTimeOut: Double = 30
var parmeterStr: String = ""


/// 网络请求的基本设置,这里可以拿到是具体的哪个网络请求，可以在这里做一些设置
private let myEndpointClosure = { (target: API) -> Endpoint in
    /// 这里把endpoint重新构造一遍主要为了解决网络请求地址里面含有? 时无法解析的bug
    let url = target.baseURL.absoluteString + target.path
    var task = target.task
    /*
     如果需要在每个请求中都添加类似token参数的参数请取消注释下面代码
     */
//    let additionalParameters = ["token":"888888"]
//    let defaultEncoding = URLEncoding.default
//    switch target.task {
//        ///在你需要添加的请求方式中做修改就行，不用的case 可以删掉。。
//    case .requestPlain:
//        task = .requestParameters(parameters: additionalParameters, encoding: defaultEncoding)
//    case .requestParameters(var parameters, let encoding):
//        additionalParameters.forEach { parameters[$0.key] = $0.value }
//        task = .requestParameters(parameters: parameters, encoding: encoding)
//    default:
//        break
//    }
    /*
     如果需要在每个请求中都添加类似token参数的参数请取消注释上面代码
     */

    var endpoint = Endpoint(
        url: url,
        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
        method: target.method,
        task: task,
        httpHeaderFields: target.headers
    )
    requestTimeOut = 30 // 每次请求都会调用endpointClosure 到这里设置超时时长 也可单独每个接口设置
    switch target {
    default:
        return endpoint
    }
}


/// 网络请求的设置
private let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        // 设置请求时长
        request.timeoutInterval = requestTimeOut
        // 打印请求参数
        if let requestData = request.httpBody {
            print("\(request.url!)" + "\n" + "\(request.httpMethod ?? "")" + "发送参数" + "\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")")
            parmeterStr = String(data: request.httpBody!, encoding: String.Encoding.utf8)!
            
        // [URL absoluteString];
            
        } else {
            print("\(request.url!)" + "\(String(describing: request.httpMethod))")
        }
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}

/// /网络请求发送的核心初始化方法，创建网络请求对象
let Provider = MoyaProvider<API>(endpointClosure: myEndpointClosure, requestClosure: requestClosure, trackInflights: false)

//struct LoginClient{
//    static let shared = LoginClient()
//
//
//
//    /// 网络请求的基本设置,这里可以拿到是具体的哪个网络请求，可以在这里做一些设置
//    private let myEndpointClosure = { (target: API) -> Endpoint in
//        /// 这里把endpoint重新构造一遍主要为了解决网络请求地址里面含有? 时无法解析的bug
//        let url = target.baseURL.absoluteString + target.path
//        var task = target.task
//        /*
//         如果需要在每个请求中都添加类似token参数的参数请取消注释下面代码
//         */
//    //    let additionalParameters = ["token":"888888"]
//    //    let defaultEncoding = URLEncoding.default
//    //    switch target.task {
//    //        ///在你需要添加的请求方式中做修改就行，不用的case 可以删掉。。
//    //    case .requestPlain:
//    //        task = .requestParameters(parameters: additionalParameters, encoding: defaultEncoding)
//    //    case .requestParameters(var parameters, let encoding):
//    //        additionalParameters.forEach { parameters[$0.key] = $0.value }
//    //        task = .requestParameters(parameters: parameters, encoding: encoding)
//    //    default:
//    //        break
//    //    }
//        /*
//         如果需要在每个请求中都添加类似token参数的参数请取消注释上面代码
//         */
//
//        var endpoint = Endpoint(
//            url: url,
//            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
//            method: target.method,
//            task: task,
//            httpHeaderFields: target.headers
//        )
//        requestTimeOut = 30 // 每次请求都会调用endpointClosure 到这里设置超时时长 也可单独每个接口设置
//        switch target {
//        case .homeGoodsList:
//            return endpoint
//        case .homePageBelowConten:
//            requestTimeOut = 5
//            return endpoint
//        default:
//            return endpoint
//        }
//    }
//
//
//
//
//
//
//    ///解决，URL 中带有? 号被转义成 %3f 的问题
//    private let Provider = MoyaProvider<API>(endpointClosure: MoyaProvider.pqEndpointMapping)
//
//
//
//
//
//
//
//
//
//
//    func NetWorkRequest<T: HandyJSON>(api: LoginAPI, showLoading: Bool = false,lodingText: String = "", modelType: T.Type?, successCallback:@escaping RequestResultClosure, failureCallback: RequestResultClosure? = nil) -> Cancellable? {
////        // 先判断网络是否有链接 没有的话直接返回--代码略
////        if !UIDevice.isNetworkConnect {
////            // code = 9999 代表无网络  这里根据具体业务来自定义
////            errorHandler(code: 9999, message: "网络似乎出现了问题", failure: failureCallback)
////            return nil
////        }
////        return Provider.request(MultiTarget(target)) { result in
////            switch result {
////            case let .success(response):
////                do {
////                    let jsonData = try JSON(data: response.data)
////                    print("返回结果是：\(jsonData)")
////                    //改行代码为项目返回结果自测,可根据情况处理
////                    if !validateRepsonse(response: jsonData.dictionary, failure: failureCallback) { return }
////                    let respModel = ResponseModel()
////                    /// 这里的 -999的code码 需要根据具体业务来设置
////                    respModel.code = jsonData[codeKey].int ?? -999
////                    respModel.message = jsonData[messageKey].stringValue
////                    respModel.isSuccess = true
////                    if respModel.code == successCode {
////                        respModel.data = jsonData[dataKey].rawString() ?? ""
////                        successCallback(respModel)
////                    } else {
////                        errorHandler(code: respModel.code , message: respModel.message , failure: failureCallback)
////                        return
////                    }
////                } catch {
////                    // code = 1000000 代表JSON解析失败  这里根据具体业务来自定义
////                    errorHandler(code: 1000000, message: String(data: response.data, encoding: String.Encoding.utf8)!, failure: failureCallback)
////                }
////            case let .failure(error as NSError):
////                errorHandler(code: error.code, message: "网络连接失败", failure: failureCallback)
////            }
////        }
//    }
//}
//
//
///// 网络请求的设置
//private let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
//    do {
//        var request = try endpoint.urlRequest()
//        // 设置请求时长
//        request.timeoutInterval = requestTimeOut
//        // 打印请求参数
//        if let requestData = request.httpBody {
//            print("\(request.url!)" + "\n" + "\(request.httpMethod ?? "")" + "发送参数" + "\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")")
//            parmeterStr = String(data: request.httpBody!, encoding: String.Encoding.utf8)!
//
//        // [URL absoluteString];
//
//        } else {
//            print("\(request.url!)" + "\(String(describing: request.httpMethod))")
//        }
//        done(.success(request))
//    } catch {
//        done(.failure(MoyaError.underlying(error, nil)))
//    }
//}
