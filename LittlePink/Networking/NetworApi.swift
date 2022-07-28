//
//  API.swift
//  LittlePink
//
//  Created by ouyang on 2022/7/17.
//
import Moya
import Foundation

//
//enum API {
//    case login(parameters:[String:Any])    ///参数可以是字典
//    case testApi       ///无参数接口
//    case register(email:String,password:String)  ///参数可以是字符串
//    case uploadHeadImage(parameters:[String:Any],imageData:Data)
//}
//
//
//extension API:TargetType{
//    ///baseURL 也可用枚举区分不同的baseURL,不过一般只需要一个baseURL
//       var baseURL: URL {
//           return URL.init(string: baseUrl)!
//       }
//
//    ///不同接口的子路径
//      var path: String {
//          switch self {
//          case .login:
//              return "user/login"
//          case .testApi:
//              return "1111"
//          case .register(let email, _):
//              return  "/user/register/" + email
//          case .uploadHeadImage:
//              return "/image/upload"
//          }
//      }
//
//    var method: Moya.Method {
//        switch self {
//        case .login:
//            return .post
//        default:
//            return .get
//        }
//    }
//
//    /// 这个是做单元测试模拟的数据，必须要实现，只在单元测试文件中有作用
//    var sampleData: Data {
//        return "".data(using: String.Encoding.utf8)!
//    }
//
//
//    var task: Task {
//        var parmeters:[String:Any] = [:]
//            switch self {
//            case .login(let parameters):
//                parmeters = parameters
//                return .requestPlain
//            case .testApi:///无参数
//                return .requestPlain
//            case .register(let parameters):
//                parmeters = parameters
//
//            case .uploadHeadImage(let parameters, let imageData):
//                let formData = MultipartFormData(provider: .data(imageData), name: "file", fileName: "zhou.png", mimeType: "image/png")
//                return .uploadCompositeMultipart([formData], urlParameters: parameters)
//            }
//        }
//
//    ///设置请求头 具体选择看后台 有application/x-www-form-urlencoded 、application/json
//       var headers: [String : String]? {
//           switch self {
//           case .login(_):
//               return ["Content-type" : "multipart/form-data"]
//           default:
//              return ["Content-Type":"application/x-www-form-urlencoded"]
//           }
//       }
//
//}



enum API {
    case login(parameters:[String:Any])    ///参数可以是字典
    case register(parameters:[String:Any])  ///参数可以是字符串
}


extension API:TargetType{
    ///baseURL 也可用枚举区分不同的baseURL,不过一般只需要一个baseURL
       var baseURL: URL {
           return URL.init(string: baseUrl)!
       }
       
    ///不同接口的子路径
      var path: String {
          switch self {
          case .login:
              return "user/login"
          case .register:
              return  "/user/register/"
          }
      }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        default:
            return .get
        }
    }

    var task: Task {
        var parmeters:[String:Any] = [:]
            switch self {
            case .login(let parameters):
                parmeters = parameters
            case .register(let parameters):
                parmeters = parameters
            }
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
        }
    
    /// 这个是做单元测试模拟的数据，必须要实现，只在单元测试文件中有作用
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    ///设置请求头 具体选择看后台 有application/x-www-form-urlencoded 、application/json
    var headers: [String : String]? {
        switch self {
        case .login(_):
            return ["Content-type" : "multipart/form-data"]
        default:
           return ["Content-Type":"application/x-www-form-urlencoded"]
        }
    }
}
