//
//  InfoRecoViewController.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/23.
//

import UIKit
import Alamofire

class InfoRecoViewController: UIViewController{

    @IBOutlet weak var recoView: UIView!
    var recoColor: UIColor?
    
    @IBOutlet weak var recoImageView: UIImageView!
    var recoImage : UIImage?
    
    @IBOutlet weak var recoLabel: UILabel!
    var recoText : String?
    
    @IBOutlet weak var recoTableView: UITableView!
    var cellIdentifier:String = "recoCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setData(name: recoText ?? "")
        // Do any additional setup after loading the view.
    }
    
    
    //=======collection & table 다음화면으로 데이터 넘기기=======
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //카테고리 컬렉션 선택시 InfoRecoViewController 화면으로 데이터 넘기기
        if segue.destination is InfoDetailViewController{
            guard let nextViewController :InfoDetailViewController = segue.destination as? InfoDetailViewController else{
                return
            }
            guard let cell: InfoRecoTableViewCell = sender as? InfoRecoTableViewCell else{
                return
            }
            nextViewController.textToSet = cell.nameLabel?.text
        }
    }
    
    
    //데이터 모델
    var plantInitialData:[plantInitialModel] = [
//        plantInitialModel(plantImage: UIImage(named: "plant1"), name: "몬스테라", scientificName: "Monstera"),
//        plantInitialModel(plantImage: UIImage(named: "plant2"), name: "몬스테라 알보 바리에가타", scientificName: "Monstera deliciosa"),
//        plantInitialModel(plantImage: UIImage(named: "plant3"), name: "몬스테라 보르시지아나", scientificName: "Monstera"),
//        plantInitialModel(plantImage: UIImage(named: "plant4"), name: "무늬 몬스테라", scientificName: "Monstera"),
//        plantInitialModel(plantImage: UIImage(named: "plant5"), name: "몬스테라 델리오사", scientificName: "Monstera deliciosa"),
//        plantInitialModel(plantImage: UIImage(named: "plant6"), name: "몬스테라", scientificName: "Monstera")
    ]
    
    //셀의 각 요소를 들고 있는 구조체
    struct plantInitialModel{
        let plantImage : String!
        let name : String
        let scientificName : String
    }
}

//MARK: ======info 메인에서 카테고리 정보 넘겨받기======
extension InfoRecoViewController: UITableViewDelegate, UITableViewDataSource{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.recoLabel.text = self.recoText
        
        switch self.recoText{
        case "물":
            setData(name: "물 좋아함")
            break
        case "채광":
            setData(name: "음지식물")
            break
        default:
            self.recoLabel.text = self.recoText
        }
        print(recoText)
//        self.recoLabel.text = self.recoText
//        self.view.backgroundColor = UIColor(named: "infoCategoryColor1")
        self.view.backgroundColor = self.recoColor
        self.recoImageView.image = self.recoImage
    }
   
    
    //=========추천식물 table view========
    
    func setupTableView(){
        recoTableView.delegate = self
        recoTableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plantInitialData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? InfoRecoTableViewCell else {return UITableViewCell()}
        
        let item = plantInitialData[indexPath.row]
        cell.setupData(
            item.plantImage,
            item.name,
            item.scientificName
        )
        
        cell.selectionStyle = .none
        return cell
    }
    
    
    //========== 식물 정보 조회 API ===========
    func setData(name: String){
        
        self.plantInitialData.removeAll()
        //accessToken으로 kakao 유저 데이터 가져오기
        let url = API.BASE_URL + "/info/getRecommendInfo"
        let header : HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        let queryString : Parameters = ["name" : name]
        
        MyAlamofireManager.shared
            .session
            .request(url,method : .post, parameters: queryString, encoding: URLEncoding.queryString)
            .responseJSON(completionHandler: {response in
                        
                        switch response.result{
                            
                            
                        case .success(let obj):
                            print("========== 테스트ㅡ으으으 ===========")
                            print(name)
                            do{
                                let dataJson = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                                let jsonData = try JSONDecoder().decode(InfoSearchModel.self, from: dataJson)
                                print(jsonData)
                                
//                                DispatchQueue.global().async { [weak self] in
                                for i in jsonData.result{
                                    print(i.name)
                                    self.plantInitialData.append(plantInitialModel(plantImage: i.imgURL, name: i.name, scientificName: i.scientificName))
                                    
                                }
                                
                                self.recoTableView.reloadData()
                                
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
