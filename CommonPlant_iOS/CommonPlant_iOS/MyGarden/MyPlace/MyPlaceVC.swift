//
//  MyPlaceViewController.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/01/29.
//

import UIKit
import Alamofire

class MyPlaceVC: UIViewController, SendPlaceDataDelegate {
    func sendPlaceData(placeCode: [String], placeImg: UIImage) {
        
    }
    
    func sendPlaceData() {
        
    }
    
    
    @IBOutlet weak var mainTopView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var myPlaceNameLabel: UILabel!
    @IBOutlet weak var myPlaceRoadLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    var myPlaceCode: String = ""

    var myPlaceArray: [MyPlaceResult] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpTopView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData { response in
            self.myPlaceArray.append(response)
            self.myPlaceNameLabel.text = self.myPlaceArray.first?.name
            self.myPlaceRoadLabel.text = self.myPlaceArray.first?.address
            self.tempLabel.text = "\(self.myPlaceArray.first?.highestTemp ?? "9.3") / \(self.myPlaceArray.first?.minimumTemp ?? "5")"
            self.humidityLabel.text = self.myPlaceArray.first?.humidity
        }
     
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 24))
        
        navigationController?.isNavigationBarHidden = false
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setUpTopView() {
        mainTopView.layer.shadowColor = UIColor(red: 0.204, green: 0.204, blue: 0.204, alpha: 1).cgColor
        mainTopView.layer.shadowOpacity = 0.3
        mainTopView.layer.shadowRadius = 7
        mainTopView.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 199, width: mainTopView.bounds.width, height: 5)).cgPath
    }
    
}

extension MyPlaceVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.myPlaceArray.first?.plantInfoList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPlaceTableViewCell", for: indexPath) as! MyPlaceTVC? else {
            return UITableViewCell()
        }
        
        if indexPath.row != 0 {
            cell.waterBtn.layer.isHidden = true
            cell.remainderDateLabel.textColor = UIColor(named: "Gray4")
        }
        
        let myPlaceUrl = self.myPlaceArray.first?.plantInfoList[indexPath.row].imgUrl
        let myPlaceImgUrl = URL(string: myPlaceUrl!)
        cell.plantImg.kf.setImage(with: myPlaceImgUrl)
        
        
        cell.myPlantNicknameLabel.text = self.myPlaceArray.first?.plantInfoList[indexPath.row].nickname
        cell.myPlantNameLabel.text = self.myPlaceArray.first?.plantInfoList[indexPath.row].name
        
        let remainderDate = self.myPlaceArray.first?.plantInfoList[indexPath.row].remainderDate
        cell.remainderDateLabel.text = "D\(remainderDate ?? 0)"
        cell.myPlaceMemo.text = self.myPlaceArray.first?.plantInfoList[indexPath.row].recentMemo
        cell.wateredDateLabel.text = self.myPlaceArray.first?.plantInfoList[indexPath.row].wateredDate
        
        
        cell.selectionStyle = .none
        
        cell.myPlaceContentView.layer.cornerRadius = 16
        cell.myPlaceContentView.layer.borderWidth = 0.5
        cell.myPlaceContentView.layer.borderColor = UIColor(red: 0.879, green: 0.879, blue: 0.879, alpha: 1).cgColor
        
        cell.myPlaceContentView.layer.shadowColor = UIColor(red: 0.471, green: 0.471, blue: 0.471, alpha: 0.25).cgColor
        cell.myPlaceContentView.layer.shadowOpacity = 1
        cell.myPlaceContentView.layer.shadowRadius = 4
        cell.myPlaceContentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        cell.myPlaceContentView.layer.masksToBounds = false
        
        cell.plantImg.layer.cornerRadius = 16
        return cell
    }
}

extension MyPlaceVC {
    func fetchData(completion: @escaping (MyPlaceResult) -> Void){
        let accessToken: String = UserDefaults.standard.object(forKey: "token") as! String
        let url = API.BASE_URL + "/place/" + myPlaceCode
        let header : HTTPHeaders = [
            "X-AUTH-TOKEN": accessToken
        ]
        
        MyAlamofireManager.shared
            .session
            .request(url, method : .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseJSON(completionHandler: {response in
                switch response.result {
                case .success(let data):
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)

                        let myPlaceData = try! JSONDecoder().decode(MyPlaceModel.self, from: jsonData)

                        self.myPlaceArray.append(myPlaceData.result)
                        completion(myPlaceData.result)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(_): break
                }
            })
    }
}


