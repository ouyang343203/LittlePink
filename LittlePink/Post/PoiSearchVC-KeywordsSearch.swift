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
            setAroundSearchFooter()//当数据清楚以后需要调用重置周边搜索数据否者当用户加载更多的数据的时候会停留加载keywordsSearchPullToRefresh或者其他的接口
            poitableView.reloadData()
        }
    }
    //点击搜索
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isBlank else { return }
        pois.removeAll()
        currentkeywordsPage = 1
        keywords = searchText
        setKeywordsSearchFooter()
        showLoatHUD()
        makeKeywordstSearch(keywords)
    }
}

// MARK: -  根据定位经纬度获取周边POI检索信息
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
          print("兴趣点名称:\(poi.name)")
          let province = poi.province == poi.city ? "" : poi.province.unwrapedText
          let address = poi.district == poi.address ? "" : poi.address
          let detileaddress = "\(province)\(poi.city.unwrapedText)\(poi.district.unwrapedText)\(address.unwrapedText)"
          print("详细地址:\(detileaddress)")
          let poi = [poi.name ?? KNoPOIPH, detileaddress]
          pois.append(poi)
          
          // 第一次定位以后的周边搜索的第二条以后的数据添加到 数据副本存储当删除搜索内容的时候显示周边定位的数据
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
    
    func setKeywordsSearchFooter(){
        mjfooter.resetNoMoreData()
        mjfooter.setRefreshingTarget(self, refreshingAction: #selector(keywordsSearchPullToRefresh))
    }
}

extension PoiSearchVC {
    @objc func keywordsSearchPullToRefresh(){
        currentkeywordsPage += 1
        makeKeywordstSearch(keywords,currentkeywordsPage)
        endRefreshing(currentkeywordsPage)
    }
}

