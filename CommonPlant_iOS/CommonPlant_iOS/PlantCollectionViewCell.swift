//
//  PlantCollectionViewCell.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/20.
//

import UIKit

class PlantCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var categoryView: UIView!
    var categoryColor : UIColor!
    var categoryImage : UIImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setupData(
        _ categoryImage:UIImage?,
        _ cellImage: UIImage?,
        _ title: String,
        _ color: UIColor?
    ){
        if let categoryImage = categoryImage{
            self.categoryImage = categoryImage
        }else{
            self.categoryImage = UIImage(named: "InfoPlantImg")
        }
        
        if let cellImage = cellImage{
            cellImageView.image = cellImage
        }else{
            cellImageView.image = UIImage(named: "InfoPlantImg")
        }
        
        titleLabel.text = title
        
        if let color = color{
//            categoryView.backgroundColor = color
//            categoryView.layer.cornerRadius = 8
            categoryColor = color
            print("item")
        }else{
//            categoryView.backgroundColor = UIColor(named: "infoCategoryColor1")
            categoryColor = UIColor(named: "infoCategoryColor1")
            print("infoCategoryColor1")
        }
        
    }
    
}
