//
//  MyPlantVC.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/01/31.
//

import UIKit

class MyPlantVC: UIViewController {
    
    
    var userNameArray = ["커먼플랜트", "커먼맘", "커먼맘", "커먼 파파"]
    var memoLabelArray = ["장마여서 물주는 날짜를 조금 늦춤 하지만 해는 맑구나 몬테랑 함께 즐거운시간", "오늘은 잎이 조금 시들하구나 커먼아 해결책은?", "오늘은 잎의 상태가 매우 좋다 커먼아 앱에서 알려준 물주기의 주기를 참고하렴", "오늘도 맑음"]
    
    
    @IBOutlet weak var memoCollectionView: UICollectionView!
    @IBOutlet weak var plantInfoView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoCollectionView.delegate = self
        memoCollectionView.dataSource = self
        
        navigationController?.isNavigationBarHidden = false
        plantInfoView.layer.cornerRadius = 16
        
    }
    
}

extension MyPlantVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPlantCollectionViewCell", for: indexPath) as! MyPlantCollectionViewCell
        cell.userNameLabel.text = userNameArray[indexPath.row]
        cell.memoLabel.text = memoLabelArray[indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 174)
    }
    
    
}
