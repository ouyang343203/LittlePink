//
//  PoiSearchVC.swift
//  LittlePink
//
//  Created by 欧阳文 on 2021/12/3.
//

import UIKit

class PoiSearchVC: UIViewController {

    @IBOutlet weak var poitableView: UITableView!
    lazy var locationManager = AMapLocationManager()
    lazy var mapSearch = AMapSearchAPI()
    lazy var aroundSearchrequest:AMapPOIAroundSearchRequest = {
        
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(latitude), longitude: CGFloat(longitude))
        request.requireExtension = true
        return request
    }()
    
    var latitude = 0.0
    var longitude = 0.0

   // private var pois = [Array(repeating: "", count: 2)]//定义只有两个元素的嵌套数组定义
    var pois = [["不显示位置",""]]//定义有默认值的嵌套数组
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        config()//定位配置
        requstlocationData()//请求当前定位信息
        mapSearch?.delegate = self
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension PoiSearchVC:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pois.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: KPOICellID, for: indexPath) as! POICell
        cell.poiInfos = pois[indexPath.row]
        return cell
    }
}

extension PoiSearchVC:UITableViewDelegate {
    
    
}

extension PoiSearchVC:UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        
    }
}

extension PoiSearchVC:AMapLocationManagerDelegate{
    
    func amapLocationManager(_ manager: AMapLocationManager!, doRequireLocationAuth locationManager: CLLocationManager!) {
        locationManager.requestWhenInUseAuthorization()
    }
}
  // MARK: -  周边搜索
extension PoiSearchVC:AMapSearchDelegate {
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        hidLoadHUD()
        if response.count == 0 { return }
        for poi in response.pois {
            let province = poi.province == poi.city ? "不显示位置" : poi.province.unwrapedText
            let address = poi.district == poi.address ? "" : poi.address
            let detileaddress = "\(province)\(poi.city.unwrapedText)\(poi.district.unwrapedText)\(address.unwrapedText)"
            print("详细地址:\(detileaddress)")
            let poi = [province,detileaddress]
            pois.append(poi)
            poitableView.reloadData()
        }
    }
}

