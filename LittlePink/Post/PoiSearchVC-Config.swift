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
    }
    
    func requstlocationData(){
        self.showLoatHUD(nil)
        locationManager.requestLocation(withReGeocode: true, completionBlock: { [weak self] (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
                   
            guard let weakself = self else{return}// 由于闭包上使用了[weak self]所以为了防止self 不存在需要判断如果self不存在就不执行
            if let error = error {
                let error = error as NSError
                
                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
                    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
                     print("定位错误:{\(error.code) - \(error.localizedDescription)};")
                    weakself.hidLoadHUD()
                    return
                }
                else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
                    || error.code == AMapLocationErrorCode.timeOut.rawValue
                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
                    || error.code == AMapLocationErrorCode.badURL.rawValue
                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
                    
                    //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
                    print("逆地理错误:{\(error.code) - \(error.localizedDescription)};")
                    weakself.hidLoadHUD()
                }
                else {
                    //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
                }
                
                // {formattedAddress:广东省深圳市罗湖区建设路靠近新都酒店; country:中国;province:广东省; city:深圳市; district:罗湖区; citycode:0755; adcode:440303; street:建设路; number:1079号; POIName:新都酒店; AOIName:深圳站;}
                // {formattedAddress:上海市宝山区富长路靠近外环富长路桥; country:中国;province:上海市; city:上海市; district:宝山区; citycode:021; adcode:310113; street:富长路; number:1118号; POIName:外环富长路桥; AOIName:(null);}
                // {formattedAddress:西藏自治区日喀则市仲巴县; country:中国;province:西藏自治区; city:日喀则市; district:仲巴县; citycode:0892; adcode:540232; street:(null); number:(null); POIName:(null); AOIName:(null);}
            }
            
            if let location = location {
                print("经纬度地址:%@", location)
                
                // MARK: -检索开始周边POI搜索在代理AMapSearchDelegate处理
                weakself.latitude = location.coordinate.latitude
                weakself.longitude = location.coordinate.longitude
                weakself.mapSearch?.aMapPOIAroundSearch(weakself.aroundSearchrequest)
            }
        
            if let reGeocode = reGeocode {
 
                guard let formattedAddress = reGeocode.formattedAddress, !formattedAddress.isEmpty else{ return}
                let province = reGeocode.province == reGeocode.city ? "不显示位置" : reGeocode.province.unwrapedText//合并省和市是同一级的情况
                let currentPOI = [province,"\(province)\(reGeocode.city.unwrapedText )\(reGeocode.district.unwrapedText)\(reGeocode.street.unwrapedText)\(reGeocode.number.unwrapedText)"]

                weakself.pois.append(currentPOI)
                DispatchQueue.main.async {
                    weakself.poitableView.reloadData()
                }
                weakself.hidLoadHUD()
            }
        })
        
    }
}
