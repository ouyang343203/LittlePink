//
//  PoiSearchVC-Config.swift
//  LittlePink
//
//  Created by 欧阳文 on 2021/12/7.
//

import Foundation
extension PoiSearchVC {
    
    func config() {

        //定位
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters//设置精度
        locationManager.locationTimeout = 5//设置超时时间
        locationManager.reGeocodeTimeout = 5
        
        //POI周边搜索
        mapSearch?.delegate = self
        poitableView.mj_footer = mjfooter
    
    }
}

