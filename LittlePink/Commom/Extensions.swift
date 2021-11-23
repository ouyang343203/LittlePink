//
//  Extensions.swift
//  LittlePink
//
//  Created by 欧阳文 on 2021/11/17.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var radius:CGFloat {
        get{
            layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
        }
    }
}

extension UIViewController{
    func showTextHUD(_ title:String, _ subtitle:String? = nil){
        
       //提示框自动隐藏
        
        
        // MARK: -  加载框自动隐藏
        //初始化HUD窗口，并置于当前的View当中显示
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        //纯文本模式
        hud.mode = .text
        //设置提示文字
        hud.label.text = title
        //HUD窗口显示2秒后自动隐藏
        hud.detailsLabel.text = subtitle
        hud.hide(animated: true, afterDelay: 2)
    }
    
}

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
