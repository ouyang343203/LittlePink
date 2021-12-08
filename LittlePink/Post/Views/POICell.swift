//
//  POICell.swift
//  LittlePink
//
//  Created by 欧阳文 on 2021/12/7.
//

import UIKit

class POICell: UITableViewCell {

    @IBOutlet weak var PoiNameLabel: UILabel!
    @IBOutlet weak var PoisubNameLabel: UILabel!
    var poiInfos = ["",""]{
        didSet {
        
            PoiNameLabel.text = poiInfos.first
            PoisubNameLabel.text = poiInfos.last
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
