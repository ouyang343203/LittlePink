//
//  WaterfallCell.swift
//  LittlePink
//
//  Created by 欧阳文 on 2021/11/11.
//

import UIKit

class WaterfallCell: UICollectionViewCell {
    @IBOutlet weak var iamgeIv: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        iamgeIv.layer.cornerRadius = 5
        // Initialization code
    }
}
