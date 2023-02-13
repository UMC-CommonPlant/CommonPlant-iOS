//
//  AddPlaceCollectionViewCell.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/01/20.
//

import UIKit

class MainPlaceCVC: UICollectionViewCell {

    @IBOutlet weak var placeImg: UIImageView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var placeGradationView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 16
        placeImg.layer.cornerRadius = 16
        placeGradationView.backgroundColor = .clear
        placeGradationView.alpha = 0.7
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = placeGradationView.bounds
        let colors: [CGColor] = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        ]
        
        gradientLayer.cornerRadius = 16
        gradientLayer.colors = colors
        gradientLayer.locations = [0, 0.67]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.25, y: 0)
        
        placeGradationView.layer.addSublayer(gradientLayer)
    }
}
