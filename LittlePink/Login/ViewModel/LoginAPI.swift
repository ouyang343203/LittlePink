//
//  LoginAPI.swift
//  LittlePink
//
//  Created by ouyang on 2022/7/18.
//

import Foundation
import Moya

//加密key
public enum Marvel {
  static private let privateKey = "YOUR PRIVATE KEY"
  static private let publicKey = "YOUR PUBLIC KEY"
}


enum LoginAPI
{
    case login(parameters:[String:Any])    ///参数可以是字典
    case register(parameters:[String:Any])  ///参数可以是字符串
    case logout(parameters:[String:Any])  ///参数可以是字符串
}


extension LoginAPI: TargetType
{
    // 服务器地址
    public var baseURL: URL
    {
        return URL(string:"http://127.0.0.1:5000/")!
    }
    
    // 各个请求的具体路径
    public var path: String
    {
        
        switch self {
        case .login:
            return "login/"
        case .register:
            return "login/smscode/"
        case .logout:
            return "user/logout"
        }
        
    }
    
    // 请求方式
    var method: Moya.Method
    {
        
        switch self {
            
        case .login,
             .register
            :
            
            return .post
            
        default:
            
            return .get
        }
        
    }
    
    
    // 这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data
    {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    
    // 请求任务事件（这里附带上参数）
    public var task: Task
    {
       //此处参数添加加密例：
        let ts = "\(Date().timeIntervalSince1970)"
        let hash = (ts + Marvel.privateKey + Marvel.publicKey).md5

        let authParams = ["apikey": Marvel.publicKey, "ts": ts, "hash": hash]
        
        
        var param:[String:Any] = [:]
        switch self
        {
            case .login(let parameters):
                param = parameters
            case .register(let parameters):
                param = parameters
            default:
                return .requestPlain
        }
        return .requestParameters(parameters: param, encoding: URLEncoding.default)
        
    }
    
    
    // 设置请求头
    public var headers: [String: String]?
    {
        return nil
    }
}
