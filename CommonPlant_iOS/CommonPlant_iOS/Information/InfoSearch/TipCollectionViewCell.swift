//
//  TipCollectionViewCell.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/21.
//

import UIKit

class TipCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var contentLabel : UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData(
        _ title: String,
        _ content: String
    ){
        titleLabel.text = title
        contentLabel.text = content
        print(content)
    }
}
