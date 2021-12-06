//
//  Protocols.swift
//  LittlePink
//
//  Created by 欧阳文 on 2021/12/2.
//

import Foundation

protocol ChannelVCDelegate {
    
    ///  用户从选择话题页面返回的编辑笔记页面传值用
    ///  - Parameter channel: 传回来的的channel
    ///  - Parameter sunbchannel: 传回来的的sunbchannel
    func updateChannel(channel:String, sunbchannel:String)
    
}
