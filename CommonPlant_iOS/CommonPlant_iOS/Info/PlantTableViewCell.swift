//
//  PlantTableViewCell.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/16.
//

import UIKit

class PlantTableViewCell: UITableViewCell {
    
//    let plantImage : UIImage?
//    let name : String
//    let scientificName : String
//    let lastMonthCountLabel : String
    @IBOutlet weak var plantImageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var scientificNameLabel : UILabel!
    @IBOutlet weak var lastMonthCountLabel : UILabel!
    
//    @IBOutlet weak var tableContentView : UITableViewCell!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
    }
    
    
    func setupData(
        _ plantImage: UIImage?,
        _ name: String,
        _ scientificName: String,
        _ lastMonthCount: String
    ){
        if let plantImage = plantImage{
            plantImageView.image = plantImage
        }else{
            plantImageView.image = UIImage(named: "InfoPlantImg")
        }
        
        nameLabel.text = name
        
        scientificNameLabel.text = scientificName
        
        lastMonthCountLabel.text = lastMonthCount
    }

    
}
