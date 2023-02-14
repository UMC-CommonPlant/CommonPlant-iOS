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
        // Initialization code
        super.awakeFromNib()
        
        contentView.layer.masksToBounds = false

        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor(red: 0.879, green: 0.879, blue: 0.879, alpha: 1).cgColor
        
        
//        cell.contentView.layer.shadowPath = nil
//        cell.contentView.layer.shadowColor = UIColor.blue.cgColor
//        cell.contentView.layer.shadowOpacity = 1
//        cell.contentView.layer.shadowRadius = 4
//        cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        
//        cell.contentView.layer.masksToBounds = false
//        cell.contentView.layer.shadowColor = UIColor.gray.cgColor
//        cell.contentView.layer.shadowOffset = CGSizeMake(0, 5)
//        cell.contentView.layer.shadowOpacity = 0.35
//        cell.contentView.layer.shadowPath = UIBezierPath(roundedRect: cell.contentView.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
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
        _ plantImage: String!,
        _ name: String,
        _ scientificName: String,
        _ lastMonthCount: String
    ){

        
        nameLabel.text = name
        
        scientificNameLabel.text = scientificName
        
        lastMonthCountLabel.text = lastMonthCount
        
        guard let plantImage = plantImage else { return }
        //URL에는 한글, 띄어쓰기 적용 안됨
        let url = URL(string: plantImage)
//        plantImageView.load(url: url!)
        plantImageView.kf.setImage(with: url)
        plantImageView.layer.cornerRadius = 16
//        print("=============="+plantImage)
    }

    
}
