//
//  MyPlantCollectionViewCell.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/01/31.
//

import UIKit
import Kingfisher

class MyPlantCVC: UICollectionViewCell {
    
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
    
    
    func setupData(
        _ userName : String,
        _ memo : String,
        _ userImage : String,
        _ plantImage : String,
        _ date: String
    ){

        userNameLabel.text = userName
        memoLabel.text = memo
        dateLabel.text = date
        
//        var url = URL(string: userImage)
//        userProfle.kf.setImage(with: url)
//        print("=============="+userImage)

        
        //URL에는 한글, 띄어쓰기 적용 안됨
        let url = URL(string: plantImage)
        plantImg.kf.setImage(with: url)
        plantImg.layer.cornerRadius = 16
//        print("=============="+plantImage)
    }
    
}
