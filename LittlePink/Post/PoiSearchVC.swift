//
//  PoiSearchVC.swift
//  LittlePink
//
//  Created by 欧阳文 on 2021/12/3.
//

import UIKit

class PoiSearchVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var poitableView: UITableView!
    lazy var locationManager = AMapLocationManager()
    lazy var mapSearch = AMapSearchAPI()
    
    lazy var aroundSearchRequest:AMapPOIAroundSearchRequest = {//设置POI搜索
        
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(latitude), longitude: CGFloat(longitude))
        request.requireExtension = true
        return request
    }()
    
    lazy var keywordsSearchRequest:AMapPOIKeywordsSearchRequest = {//设置关键字搜索
        
        let request = AMapPOIKeywordsSearchRequest()
        request.keywords = keywords
        request.requireExtension = true
        return request
    }()
    
    var latitude = 0.0
    var longitude = 0.0
    var keywords = ""
   // private var pois = [Array(repeating: "", count: 2)]//定义只有两个元素的嵌套数组定义
    var pois = KPOIInitArray//定义有默认值的嵌套数组
    var arouSearchndpois = KPOIInitArray//定义有默认值的嵌套数组
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        config()//定位配置
        requstlocationData()// 获取当前定位的位置周边的信息
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

extension PoiSearchVC:UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView){
        searchBar.resignFirstResponder()
    }
}

extension PoiSearchVC:UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) { dismiss(animated: true, completion: nil)}
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isBlank {
            pois = arouSearchndpois
            poitableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isBlank else { return }
            pois.removeAll()
            showLoatHUD()
            keywordsSearchRequest.keywords = searchText
            mapSearch?.aMapPOIKeywordsSearch(keywordsSearchRequest)
    }
}

extension PoiSearchVC:AMapLocationManagerDelegate{
    
    func amapLocationManager(_ manager: AMapLocationManager!, doRequireLocationAuth locationManager: CLLocationManager!) {
        locationManager.requestWhenInUseAuthorization()
    }
}
  // MARK: -  根据定位经纬度获取周边搜索信息
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
            
            if request is AMapPOIAroundSearchRequest {
                arouSearchndpois.append(poi)
            }
            poitableView.reloadData()
        }
    }
}



