//
//  InfoDetailViewController.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/18.
//

import UIKit
import Alamofire


class InfoDetailViewController: UIViewController {
    
    var textToSet: String?
    var collectionIdentifire = "infoTipCell"
    
    @IBOutlet weak var plantImageView: UIImageView!
    @IBOutlet weak var textLabel : UILabel!
    @IBOutlet weak var tipCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plantDataSetting()
        setupCollectionView()
        setData(name: textToSet)
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
    

    
    
    //tip Model
    let tipData:[tipInitialModel] = [
        tipInitialModel(title: "가울철 물주기", content: "흙을 촉촉하게 유지"),
        tipInitialModel(title: "배치 장소", content: "거실 내측, 거실 창측"),
        tipInitialModel(title: "관리하기", content: "수경은 물주기가 필요 없으나, 화분은 1-2주에 한번씩 충분히 관수한다.")
    ]
    
    struct tipInitialModel{
        let title : String
        let content : String
    }
    


    
}
//MARK: =======식물 키우기 tip========

extension InfoDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func setupCollectionView(){
        tipCollectionView.delegate = self
        tipCollectionView.dataSource = self
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.itemSize = CGSize(width: 164, height: 121)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 8.0 // <- 셀 간격 설정
        flowLayout.minimumInteritemSpacing = 0
        
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
    
    //========== 식물 정보 조회 API ===========
    func setData(name: String?){
        print("========== 식물 정보 조회 API ===========")
        //accessToken으로 kakao 유저 데이터 가져오기
        let url = "http://localhost:8080/hello"
        let request = AF.request(url,
                                 method: .get,
//                                 parameters: ["name":"몬스테라"],
                                 encoding: JSONEncoding.default
//                                 headers: ["Content-Type":"application/json"]
        )
                        .validate()
        print("test")
        
        request.responseDecodable(of: InfoDetailModel.self){(response) in
                print(response)
                guard let data = response.value else {return}
                print(data)

            }
//        request.responseJSON{(response) in
//            print(response)
//        }
        print("========== 식물 정보 조회 API ===========")
    }
    
}
