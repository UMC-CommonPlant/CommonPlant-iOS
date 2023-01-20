//
//  InfoDetailViewController.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/18.
//

import UIKit

//delegate flow layout
//class InfoDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
class InfoDetailViewController: UIViewController {
    
//    var collectionCellIdentifier : String = "collectionCellIdentifier"
        
    var textToSet: String?
    
    @IBOutlet weak var nameTextLabel: UILabel!
    
//    @IBOutlet weak var infoCollectionView: UICollectionView!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupCollectionView()
    }
    
    
    
    //이전 화면에서 선택한 테이블 셀의 name 라벨 선택
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.nameTextLabel.text = self.textToSet
//        print(textToSet)
    }

    
    
    
    
    
    //======== 컬렉션 뷰 ========
//    func setupCollectionView(){
//        infoCollectionView.delegate = self
//        infoCollectionView.dataSource = self
//    }
    
    
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return InfoDetailInitialData.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.collectionCellIdentifier, for: indexPath) as? InfoDetailCollectionViewCell else { return UICollectionViewCell()}
//
//
//
//        return cell
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 164, height: 121)
//    }
//
    
    
//    //데이터 모델
//    let InfoDetailInitialData:[InfoDetailInitialModel] = [
//        InfoDetailInitialModel(title: "가을철 물주기", content: "흙을 촉촉하게 유지, 물에 잠기지 않도록 주의"),
//        InfoDetailInitialModel(title: "가을철 물주기", content: "흙을 촉촉하게 유지, 물에 잠기지 않도록 주의"),
//        InfoDetailInitialModel(title: "가을철 물주기", content: "흙을 촉촉하게 유지, 물에 잠기지 않도록 주의")
//    ]
//
//    //셀의 각 요소를 들고 있는 구조체
//    struct InfoDetailInitialModel{
//        let title : String
//        let content : String
//    }
    
    
}
