//
//  MemoListCollectionViewCell.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/02/12.
//

import UIKit
import Kingfisher

class MemoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!

    
    @IBOutlet weak var memoImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    
//    @IBOutlet weak var categoryView: UIView!
    
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setupData(
        _ memoImage: String?,
        _ userImage: String?,
        _ userName: String,
        _ content: String,
        _ createdDate: String
    ){
        if let memoImage = memoImage{
//            memoImageView.image  = UIImage(named: "plant1")
            print(memoImage)
            let url = URL(string: memoImage)
//            memoImageView.load(url: url!)
            memoImageView.kf.setImage(with: url)
            memoImageView.layer.cornerRadius = 8
        }else{
            memoImageView.isHidden = true
            contentHeight.constant = 16
//            memoImageView.image = UIImage(named: "InfoPlantImg")
        }
        
        if let userImage = userImage{
//            userImageView.image =  UIImage(named: "plant1")
//            print(userImage)
            let url = URL(string: userImage)
//            userImageView.load(url: url!)
            userImageView.kf.setImage(with: url)
            userImageView.layer.cornerRadius = userImageView.frame.height/2
            userImageView.layer.borderWidth = 1
            userImageView.clipsToBounds = true
            userImageView.layer.borderColor = UIColor.clear.cgColor
        }else{
            userImageView.image = UIImage(named: "InfoPlantImg")
        }

        userNameLabel.text = userName
        contentLabel.text = content
        createdDateLabel.text = createdDate
    }
    
}
