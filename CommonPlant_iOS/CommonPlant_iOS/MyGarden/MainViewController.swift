//
//  MainViewController.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/01/14.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var mainRequestBtn: UIButton!
    @IBOutlet weak var gradationView: UIView!
    @IBOutlet weak var addPlaceCollectionView: UICollectionView!
    @IBOutlet weak var addPlantCollectionView: UICollectionView!
    
    var placeImgArray = [
        UIImage(named: "place1.png"),
        UIImage(named: "place2.png"),
        UIImage(named: "place3.png"),
        UIImage(named: "place4.png")
    ]
    
    var placeLabel = ["스윗 홈_거실", "낫 스윗 회사_가든", "집_작업실", "본가_거실"]
    
    var plantImgArray = [
        UIImage(named: "plant1.png"),
        UIImage(named: "plant2.png"),
        UIImage(named: "plant3.png"),
        UIImage(named: "plant4.png"),
        UIImage(named: "plant5.png")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGradient()
        addPlaceCollectionView.delegate = self
        addPlaceCollectionView.dataSource = self
        addPlaceCollectionView.register(UINib(nibName: "AddPlaceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddPlaceCollectionViewCell")
        
        addPlantCollectionView.delegate = self
        addPlantCollectionView.dataSource = self
        addPlantCollectionView.register(UINib(nibName: "AddPlantCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddPlantCollectionViewCell")
    }
    
    func setUpRequestBtn() {
        mainRequestBtn.tintColor = UIColor(named: "SeaGreenDark1")
    }
    
    func setUpGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradationView.bounds
        let colors: [CGColor] = [
            UIColor(red: 0.847, green: 0.871, blue: 0.867, alpha: 1).cgColor,
            UIColor(red: 0.847, green: 0.871, blue: 0.867, alpha: 0).cgColor
        ]
        gradientLayer.colors = colors
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        gradientLayer.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: gradationView.frame.width, height: gradationView.frame.height))
        //gradientLayer.bounds = gradationView.bounds.insetBy(dx: -0.5*gradationView.bounds.size.width, dy: -0.5*gradationView.bounds.size.height)
        //gradientLayer.position = gradationView.center
        gradationView.layer.addSublayer(gradientLayer)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == addPlaceCollectionView {
            return placeImgArray.count
        } else {
            return plantImgArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == addPlaceCollectionView {
            guard let placeCell = addPlaceCollectionView.dequeueReusableCell(withReuseIdentifier: "AddPlaceCollectionViewCell", for: indexPath) as? AddPlaceCollectionViewCell else { return UICollectionViewCell() }
            placeCell.addPlaceImg.image = placeImgArray[indexPath.row]
            placeCell.placeLabel.text = placeLabel[indexPath.row]
                return placeCell
        } else {
            guard let plantCell = addPlantCollectionView.dequeueReusableCell(withReuseIdentifier: "AddPlantCollectionViewCell", for: indexPath) as? AddPlantCollectionViewCell else { return UICollectionViewCell() }
            plantCell.addPlantImg.image = plantImgArray[indexPath.row]
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

    
   





