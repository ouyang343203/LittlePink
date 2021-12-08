//
//  Constantsswift
//  LittlePink
//
//  Created by 欧阳文 on 2021/11/8
//

import Foundation
import UIKit

  // MARK: - 高德key
let KGaodekey = "7ab66ca2e7057ade7e45057aa5a61ec0"

  // MARK: - StoryboardID
let KFollowVCID = "FollowVCID"
let KNearByVCID = "NearByVCID"
let KDiscoverVCID = "DiscoverVCID"
let KWaterfallVCID = "WaterfallVCID"
let KNoteEditVCID = "NoteEditVCID"
let KChannelItemVCID = "ChannelItemVCID"


  // MARK: - cellID
let KWaterfallVCCellID = "WaterfallVCCellID"
let KPhotoCellID = "PhotoCellID"
let KPhotoFooterID = "PhotoFooterID"
let KSunchannellID = "SunchannellID"
let KPOICellID = "POICellID"
let kWaterfallPading:CGFloat = 4

  // MARK: - 主题颜色
 let mainColor = UIColor(named: "main")!

  // MARK: -业务逻辑相关
let kChannels = ["推荐","旅行","娱乐","才艺","美妆","白富美","美食","萌宠"]
let kMaxPhotoCount = 9//允许最多选择上传的照片数量
let kMaxlineCount = 4//最多列数
let kMaxBetweenspacing = 10//最大间距

let kRecordingTimeLimit = 600//拍摄视频的时长
let KlibraryTimeLimit = 600//从相册选取的视频的时长
let KMinimumTimeLimit = 30//从相册选择的最短视频时长
let KTrimmerMaxDuration = 600//剪辑的最大视屏时长
let KTrimmerMinDuration = 30//剪辑的最小视屏时长
let KMaxNotetitleCount = 10//发布帖子时title的数量
let KMaxNoteTextCount = 10//发布帖子时title的数量

//  // MARK: - 话题
let kAllSubChannels = [["穿神马是神马","就快瘦到50斤啦","花5个小时修的靓图", "网红店入坑记"],
                    ["魔都名媛会会长","爬行西藏","无边泳池只要9块9"],
                    ["小鲜肉的魔幻剧","国产动画雄起"] ,
                    ["练舞20年","还在玩小提琴吗,我已经尤克里里了哦","巴西柔术","听说拳击能减肥","乖乖交智商税吧"],
                    ["粉底没有最厚,只有更厚","最近很火的法属xx岛的面霜"],
                    ["我是白富美你是吗","康一康瞧-瞧啦"],
                    ["装x西餐厅","网红店打卡"],
                    ["我的猫儿子","我的猫女儿","我的突突突"]
                  ]
