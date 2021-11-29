//
//  NoteEditVC-CollectView.swift
//  LittlePink
//
//  Created by 欧阳文 on 2021/11/27.
//

import Foundation
import YPImagePicker
import SKPhotoBrowser
import AVKit

extension NoteEditVC:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: KPhotoCellID, for: indexPath) as! PhotoCell
        cell.photoIv.image = photos[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{

        switch kind {
            case UICollectionView.elementKindSectionHeader:
//                let footer:PhotoFooter = collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: KPhotoFooterID,for: indexPath) as! PhotoFooter
//                return footer
            fatalError("获取重用视图失败!")
            
        case UICollectionView.elementKindSectionFooter:
            
            let footer:PhotoFooter = collectionView.dequeueReusableSupplementaryView(ofKind:kind, withReuseIdentifier: KPhotoFooterID,for: indexPath) as! PhotoFooter
            footer.addPhontoBtn.addTarget(self, action: #selector(addPhotoAction(sender:)), for: .touchUpInside)
            return footer
    
        default:
            fatalError("获取重用视图失败!")
        }
     }
}

extension NoteEditVC:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        if isVideo {//视频预览需引入import AVKit
            //定义一个视频播放器，通过本地文件路径初始化
            let playerViewController = AVPlayerViewController()
            //playerViewController.player = AVPlayer(url:videopath)
            playerViewController.player = AVPlayer(url:videopath!)
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
            
        }else{//照片预览
            var images:[SKPhoto] = []
            for photo in photos{
                images.append(SKPhoto.photoWithImage(photo))
            }
            // 2. create PhotoBrowser Instance, and present from your viewController.
            let browser = SKPhotoBrowser(photos: images, initialPageIndex: indexPath.item)
            browser.delegate = self
            SKPhotoBrowserOptions.displayAction = false
            SKPhotoBrowserOptions.displayDeleteButton = true
            present(browser, animated: true, completion: {})
        }
    }
}

extension NoteEditVC:SKPhotoBrowserDelegate {
    func removePhoto(_ browser: SKPhotoBrowser, index: Int, reload: @escaping (() -> Void)) {
        photos.remove(at: index)
        reload()
        photoCollectView.reloadData()
    }
}

extension NoteEditVC{
    @objc func addPhotoAction(sender:UIButton!) {

        if photoCount < kMaxPhotoCount{
            var config = YPImagePickerConfiguration()
            // MARK: - 通配置
            config.onlySquareImagesFromCamera = true //拍照后的照片是否需要正方形
            config.showsPhotoFilters = true//显示滤镜
            config.showsVideoTrimmer = true//打开剪辑
            config.startOnScreen = YPPickerScreen.library//设置默认打开的类型 YPPickerScreen.photo 打开拍照  YPPickerScreen.library打开相册
            config.screens = [.library]//底部栏目显示条目数量
            //config.showsCrop = .none //是否提供剪辑功能
            config.targetImageSize = YPImageSize.original//显示原图
            //config.overlayView = UIView()//显层控制层面如翻转,滤镜,美颜等功能的控制层
            config.hidesBottomBar = false
            config.hidesCancelButton = false//左上角取消按钮
            config.preferredStatusBarStyle = UIStatusBarStyle.default
            
            // MARK: - 相册配置
            config.library.options = nil
            config.library.onlySquare = false//照片是否可以正方形输出
            config.library.isSquareByDefault = true
            config.library.minWidthForItem = nil//设置照片的最小宽度
            config.library.mediaType = YPlibraryMediaType.photo//允许用选择的资源类型默认是只能选择照片
            config.library.defaultMultipleSelection = true //支持是否可以多选
            config.library.preSelectItemOnMultipleSelection = true//是否可以默认选中第一张
            config.library.maxNumberOfItems = kMaxPhotoCount - photoCount
            config.library.minNumberOfItems = 1
            config.library.numberOfItemsInRow = kMaxlineCount
            config.library.spacingBetweenItems = kMaxBetweenspacing
            config.library.skipSelectionsGallery = false//是否跳过画廊编辑页面
            config.gallery.hidesRemoveButton = false// 是否显示删除按钮只有多选的照片的时候才有效
            
            let picker = YPImagePicker(configuration: config)
            picker.didFinishPicking { [unowned picker] items, cancelled in
                
                for  item in items {
                    if case let .photo(photo) = item {
                        self.photos.append(photo.image)
                    }
                }
                self.photoCollectView.reloadData()
                if cancelled {
                    print("用户点击了做上角的取消按钮")
                }
                picker.dismiss(animated: true, completion: nil)
            }
            present(picker, animated: true, completion: nil)
        }else{
            showTextHUD("最多只能选择\(kMaxPhotoCount)张!")
        }
    }
}
