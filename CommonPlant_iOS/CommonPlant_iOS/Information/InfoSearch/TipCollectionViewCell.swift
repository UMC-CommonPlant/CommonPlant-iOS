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
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor(red: 0.879, green: 0.879, blue: 0.879, alpha: 1).cgColor
        
        
//        cell.shadowView.layer.cornerRadius = 16
//
//        cell.shadowView.layer.borderWidth = 0.5
//        cell.shadowView.layer.borderColor = UIColor(red: 0.879, green: 0.879, blue: 0.879, alpha: 1).cgColor

//        cell.shadowView.layer.shadowColor = UIColor(red: 0.471, green: 0.471, blue: 0.471, alpha: 0.25).cgColor
////        cell.shadowView.layer.shadowColor = UIColor.blue.cgColor
//        cell.shadowView.layer.shadowOpacity = 1
//        cell.shadowView.layer.shadowRadius = 4
//        cell.shadowView.layer.shadowOffset = CGSize(width: 0, height: 1)

//        cell.selectionStyle = .none
        shadowView.layer.masksToBounds = true

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
