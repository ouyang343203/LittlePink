//
//  InputAccessoryView.swift
//  LittlePink
//
//  Created by 欧阳文 on 2021/11/29.
//

import UIKit

class InputAccessoryView: UIView {

    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var textCountStackView: UIStackView!
    @IBOutlet weak var textCountLabel: UILabel!
    @IBOutlet weak var maxTextCountLabel: UILabel!
    var currentCount = 0 {
        didSet {
            if currentCount <= KMaxNoteTextCount{
                textCountStackView.isHidden = true
                doneBtn.isHidden = false
            }else{
                textCountStackView.isHidden = false
                doneBtn.isHidden = true
                textCountLabel.text = "\(currentCount)"
            }
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
//    override func awakeFromNib(){
//        
//    }
}
