//
//  TabarC.swift
//  LittlePink
//
//  Created by 欧阳文 on 2021/11/16.
//

import UIKit
import YPImagePicker
import AVFoundation

class TabarVC: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool{
        
        if  viewController is PostVC  {
            
            //待做登录功能

            var config = YPImagePickerConfiguration()
            // MARK: - 通配置
            config.isScrollToChangeModesEnabled = true  //禁止左右滑动
            config.onlySquareImagesFromCamera = true //拍照后的照片是否需要正方形
            config.usesFrontCamera = false //使用前置摄像头
            config.showsPhotoFilters = true//显示滤镜
            config.showsVideoTrimmer = true//打开剪辑
            config.shouldSaveNewPicturesToAlbum = true//保存到相册
            config.albumName = "Pline"//设置相册名称
            // MARK: Bundle.main.infoDictionary 是从info里面获取  而 -Bundle.main.localizedInfoDictionary 是从国际化去的语言名称如果没有配置可能为空
            config.albumName = Bundle.main.appName
            config.startOnScreen = YPPickerScreen.library//设置默认打开的类型 YPPickerScreen.photo 打开拍照  YPPickerScreen.library打开相册
            config.screens = [.library, .video, .photo]//底部栏目显示条目数量
            //config.showsCrop = .none //是否提供剪辑功能
            config.targetImageSize = YPImageSize.original//显示原图
            //config.overlayView = UIView()//显层控制层面如翻转,滤镜,美颜等功能的控制层
            config.hidesBottomBar = false
            config.hidesCancelButton = false//左上角取消按钮
            config.preferredStatusBarStyle = UIStatusBarStyle.default
            //config.bottomMenuItemSelectedColour = UIColor(r: 38, g: 38, b: 38)
            //config.bottomMenuItemUnSelectedColour = UIColor(r: 153, g: 153, b: 153)
            // config.filters = [DefaultYPFilters...] 自定义滤镜
            config.maxCameraZoomFactor = 5.0 //焦距
            //config.fonts..
            
            // MARK: - 相册配置
            config.library.options = nil
            config.library.onlySquare = false//照片是否可以正方形输出
            config.library.isSquareByDefault = true
            config.library.minWidthForItem = nil//设置照片的最小宽度
            config.library.mediaType = YPlibraryMediaType.photo//允许用选择的资源类型默认是只能选择照片
            config.library.defaultMultipleSelection = false //支持是否可以多选
            config.library.preSelectItemOnMultipleSelection = true//是否可以默认选中第一张
            config.library.maxNumberOfItems = kMaxPhotoCount
            config.library.minNumberOfItems = 1
            config.library.numberOfItemsInRow = kMaxlineCount
            config.library.spacingBetweenItems = kMaxBetweenspacing
            config.library.skipSelectionsGallery = false//是否跳过画廊编辑页面
            //config.library.preselectedItems = nil
            config.gallery.hidesRemoveButton = false// 是否显示删除按钮只有多选的照片的时候才有效
            
            // MARK: - 视频配置
            //config.video.compression = AVAssetExportPresetHighestQuality//视频压缩
            config.video.fileType = .mov//  视频压缩后的保存格式类型
            config.video.recordingTimeLimit = kRecordingTimeLimit//拍摄视频的最大时长
            config.video.libraryTimeLimit = KlibraryTimeLimit//从相册选取的最大视频的时长
            config.video.minimumTimeLimit = KMinimumTimeLimit//从相册选择的最短视频时长
            config.video.trimmerMaxDuration = KTrimmerMaxDuration//剪辑的最大视频时长
            config.video.trimmerMinDuration = KTrimmerMinDuration//剪辑的最小视频时长
            
            let picker = YPImagePicker(configuration: config)
            picker.didFinishPicking { [unowned picker] items, cancelled in
//                if let photo = items.singlePhoto {
//                    print(photo.fromCamera) // Image source (camera or library)
//                    print(photo.image) // Final image selected by the user
//                    print(photo.originalImage) // original image selected by the user, unfiltered
////                    print(photo.modifiedImage) // Transformed image, can be nil 滤镜图片
////                    print(photo.exifMeta) // Print exif meta data of original image.
//                }
                if cancelled {
                    print("用户点击了做上角的取消按钮")
                    
                }
                picker.dismiss(animated: true, completion: nil)
            }
            present(picker, animated: true, completion: nil)
            return false
        }
    print("非该类型")
        return true
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
