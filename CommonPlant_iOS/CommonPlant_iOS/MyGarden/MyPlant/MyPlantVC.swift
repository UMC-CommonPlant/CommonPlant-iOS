//
//  MyPlantVC.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/01/31.
//

import UIKit
import Alamofire

class MyPlantVC: UIViewController {
    
    
    var userNameArray = ["커먼플랜트", "커먼맘", "커먼맘", "커먼 파파"]
    var memoLabelArray = ["장마여서 물주는 날짜를 조금 늦춤 하지만 해는 맑구나 몬테랑 함께 즐거운시간", "오늘은 잎이 조금 시들하구나 커먼아 해결책은?", "오늘은 잎의 상태가 매우 좋다 커먼아 앱에서 알려준 물주기의 주기를 참고하렴", "오늘도 맑음"]
    
    
    @IBOutlet weak var memoCollectionView: UICollectionView!
    @IBOutlet weak var plantInfoView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(plantIdx: 4)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPlantCollectionViewCell", for: indexPath) as! MyPlantCVC
        cell.userNameLabel.text = userNameArray[indexPath.row]
        cell.memoLabel.text = memoLabelArray[indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 174)
    }
    
    
}

extension MyPlantVC {
    func fetchData(plantIdx: Int){
          var accessToken: String = UserDefaults.standard.object(forKey: "token") as! String ?? ""
//        var accessToken: String =  "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIwMWVkYTg2Yy05ZWMxLTFmOGMtOTQyMC04YTIzMThjNDdlNjUiLCJpYXQiOjE2NzYwMDYyMDEsImV4cCI6MTY3NjAzMTQwMX0.utfKaqaLpMfLAjyJAqU1YT1BpyOX_gAXvpIP9E3hRMA"
        print(accessToken)
        let url = API.BASE_URL + "/plant/card/"+String(plantIdx)
        let header : HTTPHeaders = [
            "Content-Type": "application/json",
            "X-AUTH-TOKEN": accessToken
        ]
        MyAlamofireManager.shared
            .session
            .request(url,method : .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseJSON(completionHandler: {response in
                switch response.result {
                case .success(let data):
                    do {
                        let dataJson = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
//                        print(dataJson)
                        print("======printed data json =========")
                        let jsonData = try JSONDecoder().decode(MyPlantModel.self, from: dataJson)

                        print(jsonData)
                        print("======print jsonData=========")

                        
                    } catch {
                        print("에러")
                    }
                case .failure(_): break
                    
                }
            })
        
    }
}

