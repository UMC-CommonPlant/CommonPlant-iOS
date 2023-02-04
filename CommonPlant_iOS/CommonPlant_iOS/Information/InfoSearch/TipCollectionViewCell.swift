//
//  TipCollectionViewCell.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/23.
//

import UIKit

class TipCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var contentLabel : UILabel!
    
//    @IBOutlet weak var tipContentView: UIView!
    
    @IBOutlet weak var shadowView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        shadowView.layer.cornerRadius = 16
//        shadowView.layer.masksToBounds = true
//
//        shadowView.layer.cornerRadius = 16
//        shadowView.layer.masksToBounds = false
//
//        shadowView.layer.shadowColor = UIColor.blue.cgColor
//        shadowView.layer.shadowOpacity = 1
//        shadowView.layer.shadowRadius = 4
//        shadowView.layer.shadowOffset = CGSize(width: 0, height: 1)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 12))
    }
    
    
    func setupData(
        _ title: String,
        _ content: String
    ){
        titleLabel.text = title
        contentLabel.text = content
        print(content)
    }
}
