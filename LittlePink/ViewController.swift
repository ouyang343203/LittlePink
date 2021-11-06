//
//  ViewController.swift
//  LittlePink
//
//  Created by able on 2021/11/1.
//  创建tabar方法
//  方法一：直接在storyboard中拖入一个tarbarcontroll
//  方法二：直接在storyboard全部congtoll在右下角选中最右边的带向下的图标

//  Assets中的AccentColor颜色可以设置两种颜色用来支持深色模式和浅色模式
//  修改tabaritem的选中后的颜色可以选中tabar到右侧控制栏目中选择 imagetint
//  设置主题颜色 在Assets中选择添加Colorset
//  在storyboard中修改tabar的title选中颜色在iamge Tint 中更改选中后的额title颜色参考https://www.jianshu.com/p/a35edb802e22)
//  强制设置默认深色和浅色  在infoplist中添加Appearance （Light白色） （Duck深色）



import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        tabBarController?.tabBar.tintColor = .red//设选中当前
//        tabBarController?.tabBar.backgroundColor = .yellow
    }


}

