//
//  MainViewController.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/01/14.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var requestBtn: UIButton!
    @IBOutlet weak var addPlaceCollectionView: UICollectionView!
    @IBOutlet weak var addPlantCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  requestBtn.titleLabel.font = UIFont(name: <#T##String#>, size: <#T##CGFloat#>)
        
        addPlaceCollectionView.delegate = self
        addPlaceCollectionView.dataSource = self
        addPlaceCollectionView.register(UINib(nibName: "AddPlaceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddPlaceCollectionViewCell")
        
        addPlantCollectionView.delegate = self
        addPlantCollectionView.dataSource = self
        addPlantCollectionView.register(UINib(nibName: "AddPlantCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddPlantCollectionViewCell")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == addPlaceCollectionView {
            return 5
        } else {
            return 5
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == addPlaceCollectionView {
            guard let placeCell = addPlaceCollectionView.dequeueReusableCell(withReuseIdentifier: "AddPlaceCollectionViewCell", for: indexPath) as? AddPlaceCollectionViewCell else { return UICollectionViewCell() }
            
                return placeCell
        } else {
            guard let plantCell = addPlantCollectionView.dequeueReusableCell(withReuseIdentifier: "AddPlantCollectionViewCell", for: indexPath) as? AddPlantCollectionViewCell else { return UICollectionViewCell() }
            plantCell.addPlantLabel.text = "My Plant"
            return plantCell
        }
    }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == addPlaceCollectionView {
            return CGSize(width: 250, height: 156)
        } else {
            return CGSize(width: 164, height: 108)
        }
    }
}

    
   





