//
//  NetworkingManager.swift
//  LittlePink
//
//  Created by ouyang on 2022/7/17.
//

import Foundation
import Moya
import Alamofire
import HandyJSON

struct NetworkingManager{
    static let shared = NetworkingManager()
    

    // 成功回调
    typealias RequestSuccessCallback = ((_ model: Any?, _ message: String?, _ resposneStr: String) -> Void)
    // 失败回调
    typealias RequestFailureCallback = ((_ code: Int?, _ message: String?) -> Void)
    
    // 回调 包括：网络请求的模型(code,message,data等，具体根据业务来定)
    typealias RequestResultClosure = ((BaseModel) -> Void)
    
    ///解决，URL 中带有? 号被转义成 %3f 的问题
    private let provider = MoyaProvider<API>(endpointClosure: MoyaProvider.pqEndpointMapping)
    
    func NetWorkRequest<T: HandyJSON>(api: API, showLoading: Bool = false, lodingText: String = "", modelType: T.Type?, successCallback: RequestSuccessCallback?, failureCallback: RequestFailureCallback? = nil) -> Cancellable? {
        
        if showLoading{
        print("弹出加载提示框")
        }
//
//        return provider.request(target) { result in
//            // 隐藏hud
//            switch result {
//            case let .success(response):
//                do {
//                    let jsonData = try JSON(data: response.data)
//    //                // data里面不返回数据 只是简单的网络请求 无需转模型
//    //                if jsonData["data"].dictionaryObject == nil, jsonData["data"].arrayObject == nil { // 返回字符串
//    //                    successCallback?(jsonData["data"].string, jsonData["message"].stringValue, String(data: response.data, encoding: String.Encoding.utf8)!)
//    //                    return
//    //                }
//    //
//    //                if jsonData["data"].dictionaryObject != nil { // 字典转model
//    //                    if let model = T(JSONString: jsonData["data"].rawString() ?? "") {
//    //                        successCallback?(model, jsonData["message"].stringValue, String(data: response.data, encoding: String.Encoding.utf8)!)
//    //                    } else {
//    //                        failureCallback?(jsonData["data"].intValue, "解析失败")
//    //                    }
//    //                } else if jsonData["data"].arrayObject != nil { // 数组转model
//    //                    if let model = [T](JSONString: jsonData["data"].rawString() ?? "") {
//    //                        successCallback?(model, jsonData["message"].stringValue, String(data: response.data, encoding: String.Encoding.utf8)!)
//    //                    } else {
//    //                        failureCallback?(jsonData["data"].intValue, "解析失败")
//    //                    }
//    //                }
//
//
//                    successCallback?(jsonData["data"].string, jsonData["message"].stringValue, String(data: response.data, encoding: String.Encoding.utf8)!)
//                } catch {}
//            case let .failure(error):
//                // 网络连接失败，提示用户
//                print("网络连接失败\(error)")
//                failureCallback?(nil, "网络连接失败")
//            }
//        }
        
        provider.request(api) { progressResponse in
            
            guard let progressObj = progressResponse.progressObject else {
                return
            }
            
            successCallback?
            
            
        } completion: { result in
        
            switch result {
                
            case .success(let response):
                
                Log(message: "url = \(response.request?.url?.absoluteString ?? "")请求成功-状态码为：\(response.statusCode)")
                
                //需要重新登录
                if response.statusCode == 401 {
                    //                        LoginManager.share.signout()
                    failClosure(true, false)
                    return
                }
                
                if (response.statusCode >= 200 && response.statusCode <= 299) {
                    
                    if let dataArr = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.mutableLeaves) as? [Any] {//数组
                        
                        Log(message: "result-dataArr = \(dataArr)")
                        
                        successClosure(dataArr, nil, nil)
                        
                    }else if let dataDic = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.mutableLeaves) as? [String: Any] {//字典
                        
//                            let string = String(data: response.data, encoding: String.Encoding.utf8)
//                            if string != nil {
//                                Log(message: "string = \(string)")
//                            }
                        
                        //错误处理
                        if let code = dataDic["code"] as? Int, code != 200 {
                            
                            if let errorMsg = dataDic["message"] as? String {
                                
                                if showError {
                                    NoticeTool.showInWindow(errorMsg)
                                }else {
                                    showErrorClosure?(errorMsg)
                                }
                                
                            }
                            
                            
                            failClosure(true, false)
                            
                            return
                            
                        }
                        
                        if let dataArr = dataDic["data"] as? [Any] {
                            
                            if let dataDic = dataArr.first as? [String : Any], dataArr.count == 1 {
                                
                                #if DEBUG
                                if let jsonData = try? JSONSerialization.data(withJSONObject: dataDic, options: [.prettyPrinted]) {
                                    let dicStr = String(data: jsonData, encoding: .utf8)
                                    Log(message: "dicStr = \(dicStr ?? "")")
                                }

                                #endif
                                
                                successClosure(nil, dataDic, nil)
                                
                               
                                
                            }else {
                                
                               #if DEBUG
                                if let jsonData = try? JSONSerialization.data(withJSONObject: dataArr, options: [.prettyPrinted]) {
                                    let dicStr = String(data: jsonData, encoding: .utf8)
                                    Log(message: "dicStr = \(dicStr ?? "")")
                                }
                                
                              #endif
                                successClosure(dataArr, nil, nil)
                            }
                            
                            return
                        }
                        
                        successClosure(nil, dataDic["data"] as? [String : Any], nil)
                        
                    }else if let string = String(data: response.data, encoding: String.Encoding.utf8) {//字符串
                        
                        Log(message: "result-string = \(string)")
                        //                        if response.data.isEmpty == false {
                        successClosure(nil, nil, string)
                        //                        }
                        
                        
                    }else {
                        //                        NoticeTool.showInWindow("不可以识别")
                        dataClosure?(response.data)
                    }
                    
                    
                }else {
                    
                    if let dataDic = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.mutableLeaves) as? [String: Any] {//字典
                        
                        Log(message: "result-dicArr = \(dataDic)")
                        
                        //错误处理
                        if let errorDic = dataDic["error"] as? [String: Any] {
                            
                            if let errorMsg = errorDic["message"] as? String {
                                
                                if showError {
                                    NoticeTool.showInWindow(errorMsg)
                                }else {
                                    showErrorClosure?(errorMsg)
                                }
                                
                            }
                            
                            
                            failClosure(true, false)
                            
                            return
                            
                        }
                    }
                    
                    failClosure(true, false)
                }
                
                
                
                
            case .failure(let moyaError):
                
                
                if showNoNetWorkError {
                    NoticeTool.showInWindow("No network connection")
                }
                
                failClosure(false, true)
                
                switch moyaError {
                    
                case .statusCode(let response):
                    Log(message: "请求错误-状态码为：\(response.statusCode)")
                    
                default:
                    Log(message: "\(moyaError)")
                }
                
                
            }
            
        }
        
    }

}
