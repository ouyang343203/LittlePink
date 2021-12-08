//
//  Extensions.swift
//  LittlePink
//
//  Created by 欧阳文 on 2021/11/17.
//

import Foundation
import UIKit
import MBProgressHUD

//  设置属性是空的情况
extension  Optional where Wrapped == String  {
    //计算属性
    var unwrapedText:String{ self ?? ""}
}

extension UITextField {
    //计算属性
    var unwrapedText:String{ text ?? ""}
}


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
    
      // MARK: - 加载提示框
    func showLoatHUD(_ title:String? = nil){
     
        DispatchQueue.main.async {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.label.text = title
        }
    }
   
    func hidLoadHUD() {
        
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
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
    
    func hideKeyboardWhenTapeedAroun(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false//该属性的设置是为了避免类似celldelect点击无效
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
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
    
    static func loadView<T>(fromNib name:String, with type: T.Type) -> T{
        
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options:nil)?.first as? T {
            return view
        }
        fatalError("加载\(type)类型失败")
    }
}

