//
//  PhotoFooter.swift
//  LittlePink
//
//  Created by 欧阳文 on 2021/11/23.
//

import UIKit

class PhotoFooter: UICollectionReusableView {
        
    @IBOutlet weak var addPhontoBtn: UIButton!
    override func awakeFromNib() {
          super.awakeFromNib()
        addPhontoBtn.layer.borderWidth = 1
        addPhontoBtn.layer.borderColor = UIColor.quaternaryLabel.cgColor
        addPhontoBtn.layer.cornerRadius = 10
      }
}
