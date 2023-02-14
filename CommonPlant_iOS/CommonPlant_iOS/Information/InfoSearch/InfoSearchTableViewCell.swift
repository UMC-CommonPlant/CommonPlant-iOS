//
//  InfoSearchTableViewCell.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/16.
//

import UIKit
import Kingfisher

class InfoSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var plantImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scientificNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(
        _ imgUrl: String!,
        _ name: String,
        _ scientificName: String
    ){
        
        print("================이미지 적립중")

        guard let imageURL = imgUrl else { return }
        //URL에는 한글, 띄어쓰기 적용 안됨
        let url = URL(string: imgUrl)
//        plantImageView.load(url: url!)
        plantImageView.kf.setImage(with: url)
        plantImageView.layer.cornerRadius = 16
        
        nameLabel.text = name
        
        scientificNameLabel.text = scientificName
    }

}

