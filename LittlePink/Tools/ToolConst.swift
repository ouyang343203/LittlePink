//
//  ToolConst.swift
//  LittlePink
//
//  Created by ouyang on 2022/7/14.
//

import Foundation

let CHANNEL_ID = "1203"

///标签栏的高度 . 状态栏的高度 . 导航栏的高度
public let kTabbarHeight:CGFloat = 49


///状态栏的高度
 func height_staBar() -> CGFloat{
    if UIDevice.isIphoneXSeri(){
        return 44.0
    }
    return 20.0
}

///导航栏高度,不包括状态栏
func height_NavigationBar() -> CGFloat {
    if #available(iOS 12.0, *) {
        if UIDevice.isIpad() { return 50.0 }
    }
    return 44.0
}

///导航栏加状态栏的高度
func height_navStaBar() -> CGFloat{
    
    return height_staBar() + height_NavigationBar()
}

//状态栏高度
let status_height = UIApplication.shared.statusBarFrame.size.height

func Log<T>( message : T, file : String = #file, funcName : String = #function, lineNumber : Int = #line) {
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent
        let ocFileName = fileName as NSString
        var str = ""
        if ocFileName.hasSuffix(".swift") {
            let range = ocFileName.range(of: ".swift")
            str = ocFileName.substring(to: range.location)
        }
        
        print("[\(str)-\(funcName)-line:\(lineNumber)]: \(message)")
        
    #endif
}


///获取keywindow
public func getCurrentWindow() ->UIWindow{

    var window:UIWindow?

    if let delegate = UIApplication.shared.delegate {

        window = delegate.window!

    }else{

        window = UIApplication.shared.windows.last
    }
    return window ?? UIWindow()
}

//获取Appdelegate对象
let KAppDelegate = UIApplication.shared.delegate as! AppDelegate

//获取设备的物理高度
let kScreenHeight = UIScreen.main.bounds.size.height

//获取设备的物理宽度
let kScreenWidth = UIScreen.main.bounds.size.width

//获取真实值
func realValue (_ value: CGFloat) -> CGFloat {
    return kScreenWidth * value / 375.0
}
