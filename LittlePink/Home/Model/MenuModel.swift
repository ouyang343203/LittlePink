//
//  MenuModel.swift
//  LittlePink
//
//  Created by ouyang on 2022/6/16.
//

import UIKit

class MenuModel: NSObject {
    var imageName:String
    var menuName:String
    var price:Double = 0.0
    
    init(imageName: String, menuName:String,price:Double){
        self.imageName = imageName
        self.menuName = menuName
        self.price = price
        
    }
}
