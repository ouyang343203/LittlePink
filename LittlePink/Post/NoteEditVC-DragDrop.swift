//
//  NoteEditVC-DragDrop.swift
//  LittlePink
//
//  Created by 欧阳文 on 2021/11/25.
//

import Foundation


  // MARK: - UICollectionViewDragDelegate  开始拖拽
extension NoteEditVC:UICollectionViewDragDelegate {
    
      // MARK: -  开始拖拽单独个数据的时候使用
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        //可用indextpath 判断某section或者item是否可以拖动,若不能托送返回空数组
        let itemProvider = NSItemProvider(object:photos[indexPath.item])//获取当前用户拖拽的数据
        let dragItem = UIDragItem(itemProvider:itemProvider)
        dragItem.localObject = photos[indexPath.item]//传递拖拽的对象 下面放下的时候要获取这个对象
        return [dragItem]
    }
    
    // MARK: -  拖拽多个个数据的时候使用
   /* func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        
    }*/
    
  // MARK: -更改拖拽的外观
    /*func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        
    }*/
    
}

// MARK: - UICollectionViewDragDelegate  放下拖拽
extension NoteEditVC:UICollectionViewDropDelegate {
    
     // MARK: -拖拽中使用他可以返回拖拽提案: 拖拽/复制/制定禁止拖拽某个区域等
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        
        if collectionView.hasActiveDrag {//有有效的拖拽
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)//无有效拖拽直接禁止拖拽
    }
    
    //放下拖拽
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        
        if coordinator.proposal.operation == .move,let photo = coordinator.items.first/*当前被拖拽的数对象*/,let sourceIndex = photo.sourceIndexPath /*当前被拖拽的数据位置*/,let destinationIndexPath = coordinator.destinationIndexPath/*放下时候的位置*/ {
            
           // let item = coordinator.items.first /*当前被拖拽的数据*/
           //  let itemindext = coordinator.items.first?.sourceIndexPath?.item/*当前被拖拽的数据位置*/
            collectionView.performBatchUpdates {// 调用performBatchUpdates函数更新会更流畅
                photos.remove(at: sourceIndex.item)//移除原来的位置
                photos.insert(photo.dragItem.localObject/*当前被拖拽的数据*/ as! UIImage, at: destinationIndexPath.item)//在目的地位置插入原来的数据
                collectionView.moveItem(at: sourceIndex, to: destinationIndexPath)
            }
            coordinator.drop(photo.dragItem, toItemAt:destinationIndexPath)
        }
        
    }
    
}
