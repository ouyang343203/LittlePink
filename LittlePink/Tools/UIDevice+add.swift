//
//  UIDevice+add.swift
//  Ukaku
//
//  Created by pyx on 2021/7/28.
//

import Foundation
import UIKit


enum IphoneName: String {
    
    case    iPod_Touch_5 = "iPod_Touch_5"
    
    case    iPod_Touch_6 = "iPod_Touch_6"
    
    case    iPhone_4 = "iPhone_4"
    
    case    iPhone_4s = "iPhone_4s"
    
    case    iPhone_5 = "iPhone_5"
    
    case    iPhone_5c = "iPhone_5c"
    
    case    iPhone_5s = "iPhone_5s"
    
    case    iPhone_6 = "iPhone_6"
    
    case    iPhone_6_Plus = "iPhone_6_Plus"
    
    case    iPhone_6s = "iPhone_6s"
    
    case    iPhone_6s_Plus = "iPhone_6s_Plus"
    
    case    iPhone_7 = "iPhone_7"
    
    case    iPhone_7_Plus = "iPhone_7_Plus"
    
    case    iPhone_8 = "iPhone_8"
    
    case    iPhone_8_Plus = "iPhone_8_Plus"
    
    //X系列
    case    iPhone_X = "iPhone_X"
    
    case    iPhone_XR = "iPhone_XR"
    
    case    iPhone_XS = "iPhone_XS"
    
    case    iPhone_XS_Max = "iPhone_XS_Max"
    
    case    iPhone_11 = "iPhone_11"
    
    case    iPhone_11_pro = "iPhone_11_pro"
    
    case    iPhone_11_pro_max = "iPhone_11_pro_max"
    
    case    iPhone_SE__2nd_generation = "iPhone_SE__2nd_generation"
    
    case    iPhone_12_mini = "iPhone_12_mini"
    
    case    iPhone_12 = "iPhone_12"
    
    case    iPhone_12_pro = "iPhone_12_pro"
    
    case    iPhone_12_pro_max = "iPhone_12_pro_max"
    
    case    iPhone_13_mini = "iPhone_13_mini"
    
    case    iPhone_13 = "iPhone_13"
    
    case    iPhone_13_pro = "iPhone_13_pro"
    
    case    iPhone_13_pro_max = "iPhone_13_pro_max"
    
    case    iPad_2 = "iPad_2"
    
    case    iPad_3 = "iPad_3"
    
    case    iPad_4 = "iPad_4"
    
    case    iPad_Air = "iPad_Air"
    
    case    iPad_Air_2 = "iPad_Air_2"
    
    case    iPad_Mini = "iPad_Mini"
    
    case    iPad_Mini_2 = "iPad_Mini_2"
    
    case    iPad_Mini_3 = "iPad_Mini_3"
    
    case    iPad_Mini_4 = "iPad_Mini_4"
    
    case    iPad_Pro = "iPad_Pro"
    
    case    iPad_Seri = "otheriPadSeri" //其它的ipad系列
    
    case    Apple_TV = "Apple_TV"
    
    case   iPhone_Simulator = "iPhone_Simulator"
}


private var DeviceType: IphoneName?

///设备名称 如：xxx的iPhone
let DEVICE_NAME : String = UIDevice.current.name

///获取系统名称 例如：iPhone OS
let SYS_NAME : String = UIDevice.current.systemName

///获取系统版本 例如：9.2
let SYS_VERSION : String = UIDevice.current.systemVersion

///获取设备唯一标识符 例如：FBF2306E-A0D8-4F4B-BDED-9333B627D3E6
let DEVICE_UUID : String  = UIDevice.current.identifierForVendor!.uuidString

///获取设备的型号 例如：iPhone
let DEVICE_MODEL : String = UIDevice.current.model

///获取App的版本
let APP_VERSION : String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String

///获取App的build版本
let APP_BUILD_VERSION : String = Bundle.main.infoDictionary?["CFBundleVersion"] as! String

///获取App的名称
let APP_NAME :String  = Bundle.main.infoDictionary?["CFBundleName"] as! String


extension UIDevice {
    
    
    @objc class func isIphoneXSeri()->Bool{
            
        let mobileType = getMobileType()
        
        return mobileType == IphoneName.iPhone_X ||
            mobileType == IphoneName.iPhone_XS ||
            mobileType == IphoneName.iPhone_XR ||
        mobileType == IphoneName.iPhone_XS_Max ||
        mobileType == IphoneName.iPhone_Simulator ||
        mobileType.rawValue.contains("iPhone_11") ||
        mobileType.rawValue.contains("iPhone_12") ||
        mobileType.rawValue.contains("iPhone_13")
    
    }
    
    
    class func isIphone45()->Bool{
        
        return [IphoneName.iPhone_4,IphoneName.iPhone_4s,IphoneName.iPhone_5,IphoneName.iPhone_5s].contains(getMobileType())
    }
    
    class func isIphone678()->Bool{
        return [IphoneName.iPhone_6,IphoneName.iPhone_6s,IphoneName.iPhone_7,IphoneName.iPhone_8].contains(getMobileType())
    }
    
    class func isIphonePlus()->Bool{
        return [IphoneName.iPhone_6_Plus,IphoneName.iPhone_6s_Plus,IphoneName.iPhone_7,IphoneName.iPhone_8_Plus].contains(getMobileType())
    }
    
   
    
    
    
    ///获取手机型号 ip4 5 6 7等
    class func getMobileType()->IphoneName {
        
        if DeviceType != nil{
            
            return DeviceType!
            
        }
        
        var systemInfo = utsname()
        
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        
        let identifier = machineMirror.children.reduce("") { (identifier, element) -> String in
            let value = element.value as? Int8
            
            if value != 0 {
                
                return identifier + String(UnicodeScalar(UInt8(value!)))
                
            }else{
                return identifier
            }

        }
        
        DeviceType = getTypeString(identifier)
        return DeviceType!
    }
    
    class func isIpad()->Bool {
        
        return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
//        let typeString =  getMobileType().rawValue
//
//        return   typeString.lowercased().contains("ipad")
    }
    
    class func getTypeString(_ identifier:String)->IphoneName {
        
        switch identifier {
            
        case"iPod5,1":return IphoneName.iPod_Touch_5
            
        case"iPod7,1":return IphoneName.iPod_Touch_6
            
        case"iPhone3,1","iPhone3,2","iPhone3,3":
            return IphoneName.iPhone_4
            
        case"iPhone4,1":return IphoneName.iPhone_4s
            
        case"iPhone5,1","iPhone5,2":return IphoneName.iPhone_5
            
        case"iPhone5,3","iPhone5,4":return IphoneName.iPhone_5c
            
        case"iPhone6,1","iPhone6,2":return IphoneName.iPhone_5s
            
        case"iPhone7,2":return IphoneName.iPhone_6
            
        case"iPhone7,1":return IphoneName.iPhone_6_Plus
            
        case"iPhone8,1":return IphoneName.iPhone_6s
            
        case"iPhone8,2":return IphoneName.iPhone_6s_Plus
            
        case "iPhone9,1","iPhone9,3":return IphoneName.iPhone_7
        case "iPhone9,2","iPhone9,4":return IphoneName.iPhone_7_Plus
        case "iPhone10,1","iPhone10,4":return IphoneName.iPhone_8
        case"iPhone10,2":return IphoneName.iPhone_8_Plus
        case "iPhone10,3","iPhone10,6":return IphoneName.iPhone_X
        case "iPhone11,8":return IphoneName.iPhone_XR
        case "iPhone11,2":return IphoneName.iPhone_XS
        case "iPhone11,6", "iPhone11,4":return IphoneName.iPhone_XS_Max
        
        case "iPhone12,1":return IphoneName.iPhone_11
        case "iPhone12,3":return IphoneName.iPhone_11_pro
        case "iPhone12,5":return IphoneName.iPhone_11_pro_max
            
        case "iPhone12,8":return IphoneName.iPhone_SE__2nd_generation
        case "iPhone13,1":return IphoneName.iPhone_12_mini
        case "iPhone13,2":return IphoneName.iPhone_12
        case "iPhone13,3":return IphoneName.iPhone_12_pro
        case "iPhone13,4":return IphoneName.iPhone_12_pro_max
        case "iPhone14,4":return IphoneName.iPhone_13_mini
        case "iPhone14,5":return IphoneName.iPhone_13
        case "iPhone14,2":return IphoneName.iPhone_13_pro
        case "iPhone14,3":return IphoneName.iPhone_13_pro_max
            
        case"iPad2,1","iPad2,2","iPad2,3","iPad2,4":return IphoneName.iPad_2
        case"iPad3,1","iPad3,2","iPad3,3":return IphoneName.iPad_3
            
        case"iPad3,4","iPad3,5","iPad3,6":return IphoneName.iPad_4
            
        case"iPad4,1","iPad4,2","iPad4,3":return IphoneName.iPad_Air
            
        case"iPad5,3","iPad5,4":return IphoneName.iPad_Air_2
        case"iPad2,5","iPad2,6","iPad2,7":return IphoneName.iPad_Mini
            
        case"iPad4,4","iPad4,5","iPad4,6":return IphoneName.iPad_Mini_2
            
        case"iPad4,7","iPad4,8","iPad4,9":return IphoneName.iPad_Mini_3
            
        case"iPad5,1","iPad5,2":return IphoneName.iPad_Mini_4
            
        case"iPad6,7","iPad6,8":return IphoneName.iPad_Pro
            
        case"AppleTV5,3":return IphoneName.Apple_TV
        
        case"i386","x86_64":return IphoneName.iPhone_Simulator
            
        default:return IphoneName.iPhone_X
        }
    }
    
    
    ///获取手机型号 ip4 5 6 7等
    class func getMobileType_deviceName()-> String {
        
        var systemInfo = utsname()
        
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        
        let identifier = machineMirror.children.reduce("") { (identifier, element) -> String in
            let value = element.value as? Int8
            
            if value != 0 {
                
                return identifier + String(UnicodeScalar(UInt8(value!)))
                
            }else{
                return identifier
            }

        }
        
        return getTypeString2(identifier)
    }
    
    
    class func getTypeString2(_ identifier:String)->String {
        
        switch identifier {
            
        case"iPod5,1":return IphoneName.iPod_Touch_5.rawValue
            
        case"iPod7,1":return IphoneName.iPod_Touch_6.rawValue
            
        case"iPhone3,1","iPhone3,2","iPhone3,3":
            return IphoneName.iPhone_4.rawValue
            
        case"iPhone4,1":return IphoneName.iPhone_4s.rawValue
            
        case"iPhone5,1","iPhone5,2":return IphoneName.iPhone_5.rawValue
            
        case"iPhone5,3","iPhone5,4":return IphoneName.iPhone_5c.rawValue
            
        case"iPhone6,1","iPhone6,2":return IphoneName.iPhone_5s.rawValue
            
        case"iPhone7,2":return IphoneName.iPhone_6.rawValue
            
        case"iPhone7,1":return IphoneName.iPhone_6_Plus.rawValue
            
        case"iPhone8,1":return IphoneName.iPhone_6s.rawValue
            
        case"iPhone8,2":return IphoneName.iPhone_6s_Plus.rawValue
            
        case "iPhone9,1","iPhone9,3":return IphoneName.iPhone_7.rawValue
        case "iPhone9,2","iPhone9,4":return IphoneName.iPhone_7_Plus.rawValue
        case "iPhone10,1","iPhone10,4":return IphoneName.iPhone_8.rawValue
        case"iPhone10,2":return IphoneName.iPhone_8_Plus.rawValue
        case "iPhone10,3","iPhone10,6":return IphoneName.iPhone_X.rawValue
        case "iPhone11,8":return IphoneName.iPhone_XR.rawValue
        case "iPhone11,2":return IphoneName.iPhone_XS.rawValue
        case "iPhone11,6", "iPhone11,4":return IphoneName.iPhone_XS_Max.rawValue
        
        case "iPhone12,1":return IphoneName.iPhone_11.rawValue
        case "iPhone12,3":return IphoneName.iPhone_11_pro.rawValue
        case "iPhone12,5":return IphoneName.iPhone_11_pro_max.rawValue
            
        case "iPhone12,8":return IphoneName.iPhone_SE__2nd_generation.rawValue
        case "iPhone13,1":return IphoneName.iPhone_12_mini.rawValue
        case "iPhone13,2":return IphoneName.iPhone_12.rawValue
        case "iPhone13,3":return IphoneName.iPhone_12_pro.rawValue
        case "iPhone13,4":return IphoneName.iPhone_12_pro_max.rawValue
        case "iPhone14,4":return IphoneName.iPhone_13_mini.rawValue
        case "iPhone14,5":return IphoneName.iPhone_13.rawValue
        case "iPhone14,2":return IphoneName.iPhone_13_pro.rawValue
        case "iPhone14,3":return IphoneName.iPhone_13_pro_max.rawValue
            
        case"iPad2,1","iPad2,2","iPad2,3","iPad2,4":return IphoneName.iPad_2.rawValue
        case"iPad3,1","iPad3,2","iPad3,3":return IphoneName.iPad_3.rawValue
            
        case"iPad3,4","iPad3,5","iPad3,6":return IphoneName.iPad_4.rawValue
            
        case"iPad4,1","iPad4,2","iPad4,3":return IphoneName.iPad_Air.rawValue
            
        case"iPad5,3","iPad5,4":return IphoneName.iPad_Air_2.rawValue
        case"iPad2,5","iPad2,6","iPad2,7":return IphoneName.iPad_Mini.rawValue
            
        case"iPad4,4","iPad4,5","iPad4,6":return IphoneName.iPad_Mini_2.rawValue
            
        case"iPad4,7","iPad4,8","iPad4,9":return IphoneName.iPad_Mini_3.rawValue
            
        case"iPad5,1","iPad5,2":return IphoneName.iPad_Mini_4.rawValue
            
        case"iPad6,7","iPad6,8":return IphoneName.iPad_Pro.rawValue
            
        case"AppleTV5,3":return IphoneName.Apple_TV.rawValue
        
        case"i386","x86_64":return IphoneName.iPhone_Simulator.rawValue
            
        default: return identifier
        }
    }
    
}
