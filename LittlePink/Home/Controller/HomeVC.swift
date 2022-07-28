//
//  HomeVC.swift
//  LittlePink
//
//  Created by 欧阳文 on 2021/11/8.
//  创建tabar方法
//  方法一：直接在storyboard中拖入一个tarbarcontroll
//  方法二：直接在storyboard全部congtoll在右下角选中最右边的带向下的图标

//  Assets中的AccentColor颜色可以设置两种颜色用来支持深色模式和浅色模式
//  修改tabaritem的选中后的颜色可以选中tabar到右侧控制栏目中选择 imagetint
//  设置主题颜色 在Assets中选择添加Colorset
//  在storyboard中修改tabar的title选中颜色在iamge Tint 中更改选中后的额title颜色参考https://www.jianshu.com/p/a35edb802e22)
//  强制设置默认深色和浅色  在infoplist中添加Appearance （Light白色） （Duck深色）

import UIKit
import XLPagerTabStrip

class HomeVC:ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
  // MARK: - 设置上方的导航bar
        //1 设置seledtbar--按钮下方下方线条
        settings.style.selectedBarBackgroundColor = mainColor//颜色
        settings.style.selectedBarHeight = 3//高度
         
        //2 ButtonBarP--设置文本或图片的按钮
        settings.style.buttonBarItemBackgroundColor = .clear//设置bar的背景颜色
        settings.style.buttonBarItemTitleColor = .label
        settings.style.buttonBarItemLeftRightMargin = 0//两个margin件的间距
        settings.style.buttonBarMinimumLineSpacing = 20
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 15)
        settings.style.buttonBarLeftContentInset = 115//距离View最左间距
        settings.style.buttonBarRightContentInset = 115//距离View右边间距
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //        tabBarController?.tabBar.tintColor = .red//设选中当前
        //        tabBarController?.tabBar.backgroundColor = .yellow
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
//          // MARK: - 需要在主线层重射阳设置才能默认选中指的页面
//        DispatchQueue.main.async {
//            self.moveToViewController(at: 1, animated: false)
//        }
    }
    //添加控制前
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let DiscoverVC = storyboard!.instantiateViewController(withIdentifier: KDiscoverVCID)
        let FollowVC = storyboard!.instantiateViewController(withIdentifier: KFollowVCID)
        let NearByVC = storyboard!.instantiateViewController(withIdentifier: KNearByVCID)
        return [DiscoverVC,FollowVC,NearByVC,]
    }
  // MARK: - 这个方法效果不理想会偏向左侧一边不适用 需要buttonBarLeftContentInset和buttonBarRightContentInset才有效
//    override func calculateStretchedCellWidths(_ minimumCellWidths: [CGFloat], suggestedStretchedCellWidth: CGFloat, previousNumberOfLargeCells: Int) -> CGFloat {
//        return 10
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
