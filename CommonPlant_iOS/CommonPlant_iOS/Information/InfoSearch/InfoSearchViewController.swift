//
//  InfoSearchViewController.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/16.
//

import UIKit
import Alamofire

class InfoSearchViewController: UIViewController{
    
    var textToSet: String?
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchInputLabel: UITextField!
    
    let cellIdentifier: String = "infoSearchCell"
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchInputLabel()
        self.setupTableView()
        setupSearchLabel()
    }

    func setupSearchInputLabel(){
        //이전의 검색 텍스트 받아오기
        self.searchInputLabel.text = textToSet
    }
    
    
    //InfoDetailViewController의 textLabel로 데이터 넘기기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let nextViewController: InfoDetailViewController = segue.destination as? InfoDetailViewController else{
            return
        }
        
        guard let cell: InfoSearchTableViewCell = sender as? InfoSearchTableViewCell else {
            return
        }
        
        nextViewController.textToSet = cell.nameLabel?.text
    }


    //데이터 모델
    var plantInitialData:[plantInitialModel] = [
//        plantInitialModel(plantImage: UIImage(named: "plant1"), name: "몬스테라 델리오사", scientificName: "Monstera"),
//        plantInitialModel(plantImage: UIImage(named: "plant2"), name: "몬스테라 알보 바리에가타", scientificName: "Monstera"),
//        plantInitialModel(plantImage: UIImage(named: "plant3"), name: "몬스테라 보르시지아나", scientificName: "Monstera"),
//        plantInitialModel(plantImage: UIImage(named: "plant4"), name: "무늬 몬스테라", scientificName: "Monstera"),
//        plantInitialModel(plantImage: UIImage(named: "plant5"), name: "몬스테라 델리오사", scientificName: "Monstera"),
    ]
    
    //셀의 각 요소를 들고 있는 구조체
    struct plantInitialModel{
        let imgUrl : String
        let name : String
        let scientificName : String
    }
}

//MARK: =======검색 후 결과 불러오기==========
extension InfoSearchViewController: UITextFieldDelegate{
    func setupSearchLabel(){
        self.searchInputLabel.delegate = self
    }
    
    //UITextDelegate return key 이벤트 함수 -> 엔터 눌렀을 때 검색 이벤트
    func textFieldShouldReturn(_ textField : UITextField) -> Bool{

        textField.resignFirstResponder()
        
        if textField == self.searchInputLabel {
            print(textField)
            setData(name: textField.text ?? "")
        }

        return true
    }
}

//MARK: ========검색 결과 리스트 table========
extension InfoSearchViewController: UITableViewDelegate, UITableViewDataSource{
    func setupTableView(){
        searchTableView.delegate = self
        searchTableView.dataSource = self
        setData(name: searchInputLabel.text ?? "")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plantInitialData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? InfoSearchTableViewCell else {return UITableViewCell()}
        
        let item = plantInitialData[indexPath.row]
        cell.setupData(
            item.imgUrl,
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
        let url = API.BASE_URL + "/info/searchInfo"
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

                            do{
                                let dataJson = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                                let jsonData = try JSONDecoder().decode(InfoSearchModel.self, from: dataJson)
                                print(jsonData)
                                
//                                DispatchQueue.global().async { [weak self] in
                                for i in jsonData.result{
                                    print(i.name)
                                    self.plantInitialData.append(plantInitialModel(imgUrl: i.imgURL, name: i.name, scientificName: i.scientificName))
                                    
                                }
                                
                                self.searchTableView.reloadData()
                                
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

