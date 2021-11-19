//
//  Extensions.swift
//  LittlePink
//
//  Created by 欧阳文 on 2021/11/17.
//

import Foundation

extension Bundle{
    var appName:String{
        // MARK: Bundle.main.infoDictionary 是从info里面获取  而 -Bundle.main.localizedInfoDictionary 是从国际化去的语言名称如果没有配置可能为空
        if let appName = localizedInfoDictionary?["CFBundleDisplayName"] as? String {
            return appName
        }else{
            return infoDictionary!["CFBundleDisplayName"] as! String
        }
    }
}
