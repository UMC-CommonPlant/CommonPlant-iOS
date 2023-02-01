//
//  MyPlantCollectionViewCell.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/01/31.
//

import UIKit

class MyPlantCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var myPlantContentView: UIView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var userProfle: UIImageView!
    @IBOutlet weak var plantImg: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        
        layer.cornerRadius = 16
        layer.masksToBounds = false
        
        layer.shadowColor = UIColor(red: 0.471, green: 0.471, blue: 0.471, alpha: 0.25).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 1)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 16).cgPath
    }
    
}
