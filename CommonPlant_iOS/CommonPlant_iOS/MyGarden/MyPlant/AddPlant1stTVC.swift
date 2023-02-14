//
//  AddPlant1stTVC.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/02/13.
//

import UIKit
import Kingfisher

class AddPlant1stTVC: UITableViewCell {
    @IBOutlet weak var plantImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scientificNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupData(
        _ imgUrl: String!,
        _ name: String,
        _ scientificName: String
    ){
        
        nameLabel.text = name
        scientificNameLabel.text = scientificName
        
        guard let imageURL = imgUrl else { return }
        
        //URL에는 한글, 띄어쓰기 적용 안됨
        let url = URL(string: imgUrl)
        plantImageView.kf.setImage(with: url)
    }
}
