//
//  PlantCollectionViewCell.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/20.
//

import UIKit

class PlantCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setupData(
        _ categoryImage: UIImage?,
        _ title: String,
        _ color: UIColor?
    ){
        if let categoryImage = categoryImage{
            categoryImageView.image = categoryImage
        }else{
            categoryImageView.image = UIImage(named: "InfoPlantImg")
        }
        
        titleLabel.text = title
        
        if let color = color{
            categoryView.backgroundColor = color
            categoryView.layer.cornerRadius = 8
            print("item")
        }else{
            categoryView.backgroundColor = UIColor(named: "infoCategoryColor1")
            print("infoCategoryColor1")
        }
        
    }
    
}
