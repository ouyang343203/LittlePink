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
    
    //设置POI搜索
    lazy var aroundSearchRequest:AMapPOIAroundSearchRequest = {
        
        let request = AMapPOIAroundSearchRequest()
        request.types = KPOITypes
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(latitude), longitude: CGFloat(longitude))
        request.offset = kMaPagesize
        request.requireExtension = true
        return request
    }()
    
    //设置关键字搜索
    lazy var keywordsSearchRequest:AMapPOIKeywordsSearchRequest = {
        
        let request = AMapPOIKeywordsSearchRequest()
        request.offset = kMaPagesize
        request.requireExtension = true
        return request
    }()
    lazy var mjfooter = MJRefreshAutoNormalFooter()
    
    var latitude = 0.0
    var longitude = 0.0
    var keywords = ""
    var currentaroundPage = 1
    var currentkeywordsPage = 1
    var pageCount = 1
   // private var pois = [Array(repeating: "", count: 2)]//定义只有两个元素的嵌套数组定义
    var pois = KPOIInitArray//定义有默认值的嵌套数组
    var arouSearchndpois = KPOIInitArray//定义有默认值的嵌套数组
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        config()//定位配置
        requstlocationData()// 获取当前定位的位置周边的信息
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
        if pois.count > indexPath.row {
            cell.poiInfos = pois[indexPath.row]
        }
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

extension PoiSearchVC:AMapLocationManagerDelegate{
    
    func amapLocationManager(_ manager: AMapLocationManager!, doRequireLocationAuth locationManager: CLLocationManager!) {
        locationManager.requestWhenInUseAuthorization()
    }
}

extension PoiSearchVC{
    func endRefreshing(_ currentPage:Int) {
        if currentkeywordsPage < pageCount{
            mjfooter.endRefreshing()
        }else{
            mjfooter.endRefreshingWithNoMoreData()
        }
    }
}
