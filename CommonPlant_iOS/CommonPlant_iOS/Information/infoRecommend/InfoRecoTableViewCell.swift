//
//  InfoRecoTableViewCell.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/23.
//

import UIKit

class InfoRecoTableViewCell: UITableViewCell {

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
        _ plantImage: String!,
        _ name: String,
        _ scientificName: String
    ){
        nameLabel.text = name
        
        scientificNameLabel.text = scientificName
        
        guard let plantImage = plantImage else { return }
        //URL에는 한글, 띄어쓰기 적용 안됨
        let url = URL(string: plantImage)
        plantImageView.load(url: url!)
        plantImageView.layer.cornerRadius = 16
        
    }

}
