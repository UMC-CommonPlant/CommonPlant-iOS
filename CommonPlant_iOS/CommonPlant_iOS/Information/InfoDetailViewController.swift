//
//  InfoDetailViewController.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/18.
//

import UIKit

class InfoDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var textToSet: String?
    
    @IBOutlet weak var plantImageView: UIImageView!
    
    
    @IBOutlet weak var textLabel : UILabel!
    
    @IBOutlet weak var tipCollectionView: UICollectionView!
    var collectionIdentifire = "infoTipCell"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plantDataSetting()
        setupCollectionView()
        // Do any additional setup after loading the view.
    }
    
    func plantDataSetting(){
        plantImageView.layer.cornerRadius = 16
    }
    
    
    //======= info search에서의 식물 이름 데이터 넘기기 ======
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.textLabel.text = self.textToSet
        print(textToSet)
    }
    
    
    
    //=======식물 키우기========
    func setupCollectionView(){
        tipCollectionView.delegate = self
        tipCollectionView.dataSource = self
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        
//        var width:CGFloat = UIScreen.main.bounds.width / 3.0
        
        flowLayout.itemSize = CGSize(width: 164, height: 121)
        tipCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        tipCollectionView.collectionViewLayout = flowLayout
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tipData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : TipCollectionViewCell = tipCollectionView.dequeueReusableCell(withReuseIdentifier: self.collectionIdentifire, for: indexPath) as! TipCollectionViewCell
        
        let item = tipData[indexPath.row]
        
        cell.setupData(
            item.title,
            item.content
        )
        
        return cell
    }
    
    
    
    let tipData:[tipInitialModel] = [
        tipInitialModel(title: "가울철 물주기", content: "흙을 촉촉하게 유지"),
        tipInitialModel(title: "배치 장소", content: "거실 내측, 거실 창측"),
        tipInitialModel(title: "관리하기", content: "화분은 1-2주에 한번씩 충분히 관수한다.")
    ]
    
    struct tipInitialModel{
        let title : String
        let content : String
    }
    

}
