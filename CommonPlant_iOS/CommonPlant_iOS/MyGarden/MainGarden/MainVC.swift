//
//  MainViewController.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/01/14.
//

import UIKit
import Alamofire
import Kingfisher

protocol SendPlaceDataDelegate {
    func sendPlaceData(placeCode: [String], placeImg: UIImage)
}


class MainVC: UIViewController {
    
    // MARK: - Properties
    var delegate: SendPlaceDataDelegate?

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var requestBtn: UIButton!
    @IBOutlet weak var gradationView: UIView!
    @IBOutlet weak var mainPlaceCollectionView: UICollectionView!
    @IBOutlet weak var mainPlantCollectionView: UICollectionView!
    @IBOutlet weak var addPlaceBtn: UIButton!
    
    var roadAddressInfo: String = ""
    var mainplantIndex: Int = 0
    var myGardenList: [MyGardenResult] = []
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData() { response in
            self.myGardenList.append(response)
            self.userName.text = self.myGardenList.first?.nickName
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setUpGradient()
        mainPlaceCollectionView.delegate = self
        mainPlaceCollectionView.dataSource = self
        mainPlaceCollectionView.register(UINib(nibName: "MainPlaceCVC", bundle: nil), forCellWithReuseIdentifier: "MainPlaceCVC")
        
        mainPlantCollectionView.delegate = self
        mainPlantCollectionView.dataSource = self
        mainPlantCollectionView.register(UINib(nibName: "MainPlantCVC", bundle: nil), forCellWithReuseIdentifier: "MainPlantCVC")
    }
    
    func setAttributes() {
        //친구요청 버튼 처리
    }
    
    func setUpGradient() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = gradationView.bounds
        let colors: [CGColor] = [
            UIColor(red: 0.847, green: 0.871, blue: 0.867, alpha: 0.6).cgColor,
            UIColor(red: 0.847, green: 0.871, blue: 0.867, alpha: 0).cgColor
        ]
        gradientLayer.colors = colors
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        gradationView.layer.masksToBounds = true
        gradationView.layer.addSublayer(gradientLayer)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainToMyPlace" {
            if let vc = segue.destination as? MyPlaceVC {
                vc.myPlaceCode = roadAddressInfo
                print("=============vc.myPlaceCode\(vc.myPlaceCode)==============")
            } else if segue.identifier == "mainToMyPlant" {
                if let vc = segue.destination as? MyPlantVC {
                    
                   // vc.plantIndex = mainplantIndex
                    let mainIndexString = String(mainplantIndex)
                    vc.plantIndexString = mainIndexString
                    print("=============vc.plantIndex\(vc.plantIndex)==============")
                }
            }
        }
    }
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainPlaceCollectionView {
            return myGardenList.first?.placeList.count ?? 1
        } else {
            return myGardenList.first?.plantList.count ?? 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == mainPlaceCollectionView {
            roadAddressInfo = (self.myGardenList.first?.placeList[indexPath.row].placeCode)!
            performSegue(withIdentifier: "mainToMyPlace", sender: roadAddressInfo)
        } else if collectionView == mainPlantCollectionView {
                mainplantIndex = self.myGardenList.first?.plantList[indexPath.row].plantIdx ?? 0
                print("========mainplantIndex: \(mainplantIndex)==========")
                performSegue(withIdentifier: "mainToMyPlant", sender: mainplantIndex)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainPlaceCollectionView {
            guard let placeCell = mainPlaceCollectionView.dequeueReusableCell(withReuseIdentifier: "MainPlaceCVC", for: indexPath) as? MainPlaceCVC else { return UICollectionViewCell() }

            let placeUrl = self.myGardenList.first?.placeList[indexPath.row].imgUrl ?? ""
            let placeImgUrl = URL(string: placeUrl)
            placeCell.placeImg.kf.setImage(with: placeImgUrl)
            placeCell.placeLabel.text = myGardenList.first?.placeList[indexPath.row].placeName

            return placeCell
        } else {
            guard let plantCell = mainPlantCollectionView.dequeueReusableCell(withReuseIdentifier: "MainPlantCVC", for: indexPath) as? MainPlantCVC else { return UICollectionViewCell() }
            
            let plantUrl = self.myGardenList.first?.plantList[indexPath.row].imgUrl ?? ""
            let plantImgUrl = URL(string: plantUrl)
            plantCell.plantImg.kf.setImage(with: plantImgUrl)
            
            plantCell.myPlantLabel.text = myGardenList.first?.plantList[indexPath.row].plantNickName
            return plantCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == mainPlaceCollectionView {
            return CGSize(width: 250, height: 156)
        } else {
            return CGSize(width: 164, height: 108)
        }
    }
    
}

extension MainVC {
    func fetchData(completion: @escaping (MyGardenResult) -> Void){
        let accessToken: String = UserDefaults.standard.object(forKey: "token") as! String
        let url = API.BASE_URL + "/place/myGarden"
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

                        let myGardenData = try! JSONDecoder().decode(MyGardenModel.self, from: jsonData) 

                        self.myGardenList.append(myGardenData.result)
                        completion(myGardenData.result)
                        
                        DispatchQueue.main.async {
                            self.mainPlaceCollectionView.reloadData()
                            self.mainPlantCollectionView.reloadData()
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(_): break
                }
            })
    }
}

