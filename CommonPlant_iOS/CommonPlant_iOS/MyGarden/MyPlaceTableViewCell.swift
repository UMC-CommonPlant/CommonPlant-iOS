//
//  MyPlaceTableViewCell.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/01/29.
//

import UIKit

class MyPlaceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var plantImg: UIImageView!
    @IBOutlet weak var myPlaceContentView: UIView!
    @IBOutlet weak var myPlantNameLabel: UILabel!
    @IBOutlet weak var waterBtn: UIButton!
    @IBOutlet weak var dDayLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 12))
    }

}
