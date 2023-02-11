//
//  AddPlant2ndViewController.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/02/11.
//

import UIKit

class AddPlant2ndVC: UIViewController {
    
    @IBOutlet weak var selectPlaceBtn: UIButton!
    @IBOutlet weak var placeCollectionView: UICollectionView!
    @IBOutlet weak var selectDateBtn: UIButton!
    @IBOutlet weak var calendar: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension AddPlant2ndVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = placeCollectionView.dequeueReusableCell(withReuseIdentifier: "AddPlant2ndCVC", for: indexPath) as? AddPlant2ndCVC else { return UICollectionViewCell() }

            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 156)
    }
}
