//
//  InfoDetailViewController.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/18.
//

import UIKit
import Alamofire
import Kingfisher


class InfoDetailViewController: UIViewController {
    
    var textToSet: String?
    var collectionIdentifire = "infoTipCell"
    
    @IBOutlet weak var plantImageView: UIImageView!
    @IBOutlet weak var textLabel : UILabel!
    
    @IBOutlet weak var scientificNameLabel: UILabel!
    @IBOutlet weak var waterDayLabel: UILabel!
    @IBOutlet weak var managementLabel: UILabel!
    @IBOutlet weak var sunlightLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!

    @IBOutlet weak var tipCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plantDataSetting()
        setupCollectionView()
        setData(name: textToSet ?? "")
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
    var tipData:[tipInitialModel] = [
//        tipInitialModel(title: "가울철 물주기", content: "흙을 촉촉하게 유지"),
//        tipInitialModel(title: "배치 장소", content: "거실 내측, 거실 창측"),
//        tipInitialModel(title: "관리하기", content: "수경은 물주기가 필요 없으나, 화분은 1-2주에 한번씩 충분히 관수한다.")
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
}
extension InfoDetailViewController{
    //========== 식물 정보 조회 API ===========
    func setData(name: String){
        
        //accessToken으로 kakao 유저 데이터 가져오기
        let url = API.BASE_URL + "/info/getPlantInfo"
        let header : HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        let queryString : Parameters = ["name" : name]
        
        MyAlamofireManager.shared
            .session
            .request(url,method : .post, parameters: queryString, encoding: URLEncoding.queryString)
//            .request(url,method : .post, parameters: queryString, encoding: JSONEncoding.default)
                    .responseJSON(completionHandler: {response in
                        
                        switch response.result{
                        case .success(let obj):
                            print("========== 테스트ㅡ으으으 ===========")

                            do{
                                let dataJson = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                                let jsonData = try JSONDecoder().decode(InfoDetailModel.self, from: dataJson)
                                print(jsonData.result)
                                
                                //데이터 넣기
                                let url = URL(string: jsonData.result.imgURL)
//                                self.plantImageView.load(url: url!)
                                self.plantImageView.kf.setImage(with: url)
                                self.managementLabel.text = jsonData.result.management
                                self.scientificNameLabel.text = jsonData.result.scientificName
                                self.waterDayLabel.text = String(jsonData.result.waterDay) + " Day"
                                self.sunlightLabel.text = jsonData.result.sunlight
                                self.tempLabel.text = String(jsonData.result.tempMin)+"~"+String(jsonData.result.tempMax)+"°C"
                                self.humidityLabel.text = jsonData.result.humidity
                                
                                var month: String!
                                switch jsonData.result.month{
                                case 3,4,5:
                                    print(jsonData.result.month)
                                    month = "봄철 물주기"
                                    break
                                case 6,7,8:
                                    print(jsonData.result.month)
                                    month = "여름철 물주기"
                                    break
                                case 9,10,11:
                                    print(jsonData.result.month)
                                    month = "가을철 물주기"
                                    break
                                case 12,1,2:
                                    print(jsonData.result.month)
                                    month = "겨울철 물주기"
                                    break
                                default: break
                                }
                                
                                
                                
                                self.tipData.append(tipInitialModel(title: month, content: jsonData.result.waterType))
                                self.tipData.append(tipInitialModel(title: "배치 장소", content: jsonData.result.place))
                                self.tipData.append(tipInitialModel(title: "관리하기", content: jsonData.result.tip))
                                
                                self.tipCollectionView.reloadData()
                                
                            }catch{
                                print(error.localizedDescription)
                            }
                        
                            break
                        case .failure(let err):
                            debugPrint(err)
                            break
                        }
                    })
            }
}
//extension UIImageView {
//    func load(url: URL) {
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            }
//        }
//    }
//}
