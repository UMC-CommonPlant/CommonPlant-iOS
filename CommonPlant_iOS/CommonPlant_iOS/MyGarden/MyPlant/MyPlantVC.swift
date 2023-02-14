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
  
    var plantIndexString: String = ""
    var plantIndex: Int = 15
    var myPlantList: [MyPlantResult] = []
    
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
    
}

extension MyPlantVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPlantCollectionViewCell", for: indexPath) as! MyPlantCVC
       // cell.userNameLabel.text = userNameArray[indexPath.row]
       // cell.memoLabel.text = memoLabelArray[indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 174)
    }
    
    
}

extension MyPlantVC {
    func fetchData(completion: @escaping (MyPlantResult) -> Void){
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

                        self.myPlantList.append(myPlantData.result)
                       // print("==============myPlantData.result(myPlantData.result)==========")
                        completion(myPlantData.result)

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

