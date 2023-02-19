//
//  MyGardenCVC.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/02/15.
//

import UIKit
import Kingfisher

class MyPlaceCVC: UICollectionViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setupData(
        _ userImage: String,
        _ name: String
    ){
        
        
        nameLabel.text = name
        
        
        let url = URL(string: userImage)
        userImageView.kf.setImage(with: url)
        userImageView.layer.cornerRadius = userImageView.frame.height/2
        
    }
}
