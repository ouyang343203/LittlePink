//
//  PoiSearchVC-KeywordsSearch.swift
//  LittlePink
//
//  Created by 欧阳文 on 2021/12/12.
//

import Foundation

extension PoiSearchVC:UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) { dismiss(animated: true, completion: nil)}
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isBlank {
            pois = arouSearchndpois
            poitableView.reloadData()
        }
    }
    //点击搜索
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isBlank else { return }
        pois.removeAll()
        keywords = searchText
        mjfooter.setRefreshingTarget(self, refreshingAction: #selector(keywordsSearchPullToRefresh))
        showLoatHUD()
        makeKeywordstSearch(keywords)
    }
}

// MARK: -  根据定位经纬度获取周边搜索信息
extension PoiSearchVC:AMapSearchDelegate {
  func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
      hidLoadHUD()
      let poicount = response.count
      if poicount > kMaPagesize  {//总数据大于当前页码数量时页码+1表示还有下一页
          pageCount = poicount/kMaPagesize + 1
      }else{
          mjfooter.endRefreshingWithNoMoreData()
      }
      
      if poicount == 0 { return }
      for poi in response.pois {
          let province = poi.province == poi.city ? "不显示位置" : poi.province.unwrapedText
          let address = poi.district == poi.address ? "" : poi.address
          let detileaddress = "\(province)\(poi.city.unwrapedText)\(poi.district.unwrapedText)\(address.unwrapedText)"
          print("详细地址:\(detileaddress)")
          let poi = [province,detileaddress]
          pois.append(poi)
          
          // 第一次定位以后的周边搜索的数据副本存储
          if request is AMapPOIAroundSearchRequest {
              arouSearchndpois.append(poi)
          }
         poitableView.reloadData()
      }
  }
}

extension PoiSearchVC {
    private func makeKeywordstSearch(_ keywords:String , _ page:Int = 1) {
        keywordsSearchRequest.keywords = keywords
        keywordsSearchRequest.page = page
        mapSearch?.aMapPOIKeywordsSearch(keywordsSearchRequest)//根据定位经纬度获取周边搜索信息
    }
}

extension PoiSearchVC {
    @objc func keywordsSearchPullToRefresh(){
        currentkeywordsPage += 1
        makeKeywordstSearch(keywords,currentkeywordsPage)
        endRefreshing(currentkeywordsPage)
    }
}

