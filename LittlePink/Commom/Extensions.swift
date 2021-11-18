//
//  Extensions.swift
//  LittlePink
//
//  Created by 欧阳文 on 2021/11/17.
//

import Foundation

extension Bundle{
    var appName:String{
        if let appName = localizedInfoDictionary?["CFBundleDisplayName"] as? String {
            return appName
        }else{
            return infoDictionary!["CFBundleDisplayName"] as! String
        }
    }
}
