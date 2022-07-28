//
//  BaseModel.swift
//  LittlePink
//
//  Created by ouyang on 2022/7/17.
//

import UIKit
import HandyJSON

class BaseModel:NSObject,HandyJSON {
    required override init() {
    }
    var isSuccess : Bool = false
    var code: Int = -999
    var message: String = ""
    // 这里的data用String类型 保存response.data
    var data: String = ""
    /// 分页的游标 根据具体的业务选择是否添加这个属性
    var cursor: String = ""
}
