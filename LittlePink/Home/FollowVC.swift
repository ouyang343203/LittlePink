//
//  FollowVC.swift
//  LittlePink
//
//  Created by 欧阳文 on 2021/11/8.
//

import UIKit
import XLPagerTabStrip

class FollowVC: UIViewController,IndicatorInfoProvider {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
     func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    
//         IndicatorInfo(title: "关注")
         IndicatorInfo(title:NSLocalizedString("Follow", comment: "首页上方的关注标签"))
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
