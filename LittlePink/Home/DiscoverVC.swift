//
//  DiscoverVC.swift
//  LittlePink
//
//  Created by 欧阳文 on 2021/11/8.
//

import UIKit
import XLPagerTabStrip

class DiscoverVC: UIViewController,IndicatorInfoProvider {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
     func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        
      return "发现"
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
