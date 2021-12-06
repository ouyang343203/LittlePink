//
//  ChannelVC.swift
//  LittlePink
//
//  Created by 欧阳文 on 2021/11/30.
//

import UIKit
import XLPagerTabStrip

class ChannelVC: ButtonBarPagerTabStripViewController {

    var PVDelegate:ChannelVCDelegate?
    override func viewDidLoad() {
    
        //1 设置seledtbar--按钮下方下方线条
        settings.style.selectedBarBackgroundColor = mainColor//颜色
        settings.style.selectedBarHeight = 2//高度
         
        //2 ButtonBarP--设置文本或图片的按钮
        settings.style.buttonBarItemBackgroundColor = .clear//设置bar的背景颜色
        settings.style.buttonBarItemTitleColor = .label
        settings.style.buttonBarItemLeftRightMargin = 0//两个margin件的间距
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 13)
        settings.style.buttonBarLeftContentInset = 16//距离View最左间距
        settings.style.buttonBarRightContentInset = 16//距离View右边间距
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        containerView.bounces = false//设置禁止又回弹的效果 containerViev storyboard上的scrollcView
        //设置选中和未选中的buttonBarItemtitle颜色
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }

            oldCell?.label.textColor = .secondaryLabel
            newCell?.label.textColor = .label
            if animated {
                UIView.animate(withDuration: 0.1, animations: { () -> Void in
                    newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                })
            }
            else {
                newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        }
        
    }
    
    //添加控制前
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        var Controllers:[UIViewController] = []
        for channel in kChannels.indices{
            let channelvc = storyboard!.instantiateViewController(withIdentifier: KChannelItemVCID) as! ChannelItemVC
            channelvc.channel = kChannels[channel]
            channelvc.sunchannels = kAllSubChannels[channel]
            Controllers.append(channelvc)
        }
          return Controllers
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