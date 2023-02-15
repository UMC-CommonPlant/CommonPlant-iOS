//
//  MyPlantVC.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/01/31.
//

import UIKit
import Alamofire

class MyPlantVC: UIViewController {
    
    @IBOutlet weak var memoCollectionView: UICollectionView!
    @IBOutlet weak var plantInfoView: UIView!
  
    @IBOutlet weak var plantImgView: UIImageView!
    @IBOutlet weak var plantNameLabel: UILabel!
    @IBOutlet weak var plantScLabel: UILabel!
    
    @IBOutlet weak var meetCountLabel: UILabel!
    @IBOutlet weak var waterDayLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var updatedDateLabel: UILabel!
    
    @IBOutlet weak var wateredLabel: UILabel!
    @IBOutlet weak var manageLabel: UILabel!
    @IBOutlet weak var sunLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    
    
    var plantIndexString: String = ""
    var plantIndex: Int = 11
    var myPlantList: [memoListModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("***********plantIndexString: \(plantIndexString)*************")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData { response in
            print("===============Plant response\(response)==========")
        }
        
        memoCollectionView.delegate = self
        memoCollectionView.dataSource = self
        
        navigationController?.isNavigationBarHidden = false
        plantInfoView.layer.cornerRadius = 16
        
    }
    
    
//    @IBAction func memoBtnAction(_ sender: Any) {
//
//        let storyboard = UIStoryboard(name: "Memo", bundle: nil)
//        guard let vc = storyboard.instantiateViewController(withIdentifier: "memoList") as? MemoViewController  else { return }
//        vc.modalPresentationStyle = .fullScreen
//        vc.plantToInt = plantIndex
//        self.present(vc, animated: true, completion: nil)
//
//
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? MemoViewController {
            print("=============vc.myPlaceCode\(vc.plantToInt)==============")
//            vc.modalPresentationStyle = .fullScreen
            vc.plantToInt = plantIndex

        }
    }
    
    
    struct memoListModel{
        let userName : String
        let memo : String
        let userProfile : String
        let plantImg : String
        let dateLabel: String
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
        return myPlantList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPlantCollectionViewCell", for: indexPath) as! MyPlantCVC
       // cell.userNameLabel.text = userNameArray[indexPath.row]
       // cell.memoLabel.text = memoLabelArray[indexPath.row]
        let item = myPlantList[indexPath.row]
        cell.setupData(
            item.userName,
            item.memo,
            item.userProfile,
            item.plantImg,
            item.dateLabel
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 174)
    }
    
    
}

extension MyPlantVC {
    func fetchData(completion: @escaping (MyPlantResult) -> Void){
        self.myPlantList.removeAll()
        let accessToken: String = UserDefaults.standard.object(forKey: "token") as! String
        let url = API.BASE_URL + "/plant/card/" + "\(plantIndex)"
        let header : HTTPHeaders = [
            "X-AUTH-TOKEN": accessToken
        ]

        MyAlamofireManager.shared
            .session
            .request(url,method : .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseJSON(completionHandler: {response in
                switch response.result {
                case .success(let data):
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)

                        let myPlantData = try! JSONDecoder().decode(MyPlantModel.self, from: jsonData)

//                        self.myPlantList.append(myPlantData.result)
                       // print("==============myPlantData.result(myPlantData.result)==========")
                        completion(myPlantData.result)
                        
                        self.plantIndex = myPlantData.result.plant.plantIdx
                        
//                        self.plantImgView.layer.masksToBounds = true
                        let url = URL(string: myPlantData.result.plant.imgUrl!)
                        self.plantImgView.kf.setImage(with: url)
                        self.plantImgView.layer.cornerRadius = 16
                        self.plantNameLabel.text = myPlantData.result.plant.nickname
                        self.plantScLabel.text = myPlantData.result.plant.scientificName
                        
                        self.meetCountLabel.text = myPlantData.result.plant.nickname + "와 함께한지 \(myPlantData.result.plant.countDate)일이 지났어요!"
                        self.waterDayLabel.text = "D-\(-myPlantData.result.plant.remainderDate)"
                        self.createdDateLabel.text = myPlantData.result.plant.createdAt
                        self.updatedDateLabel.text = myPlantData.result.plant.wateredDate
                        
                        self.wateredLabel.text = "\(myPlantData.result.plant.waterDay) Day"
                        self.sunLabel.text = myPlantData.result.plant.sunlight
                        self.tempLabel.text = "\(myPlantData.result.plant.tempMin)~\(myPlantData.result.plant.tempMax)°C"
                        self.humidityLabel.text = myPlantData.result.plant.humidity
                        
                        var cnt=0
                        for i in myPlantData.result.memoList.memoCardDto{
                            var data = myPlantData.result.memoList.memoCardDto[cnt]![0]
                            self.myPlantList.append(memoListModel(userName: data.userNickName, memo: data.content, userProfile: data.userImgURL ?? "", plantImg: data.imgUrl ?? "", dateLabel: data.createdAt))

                            cnt+=1
                        }

                        DispatchQueue.main.async {
                            self.memoCollectionView.reloadData()
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(_): break
                }
            })
    }
}

