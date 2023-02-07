//
//  InfoSearchViewController.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/16.
//

import UIKit
import Alamofire

class InfoSearchViewController: UIViewController{
//    let baseurl: String = "http://localhost:8080"
    let baseurl: String = "http://common-plant.shop"
    
    var textToSet: String?
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchInputLabel: UITextField!
    
    let cellIdentifier: String = "infoSearchCell"
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchInputLabel()
        self.setupTableView()
        setData(name: searchInputLabel.text ?? "")
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
        plantInitialModel(plantImage: UIImage(named: "plant1"), name: "몬스테라 델리오사", scientificName: "Monstera"),
        plantInitialModel(plantImage: UIImage(named: "plant2"), name: "몬스테라 알보 바리에가타", scientificName: "Monstera"),
        plantInitialModel(plantImage: UIImage(named: "plant3"), name: "몬스테라 보르시지아나", scientificName: "Monstera"),
        plantInitialModel(plantImage: UIImage(named: "plant4"), name: "무늬 몬스테라", scientificName: "Monstera"),
        plantInitialModel(plantImage: UIImage(named: "plant5"), name: "몬스테라 델리오사", scientificName: "Monstera"),
    ]
    
    //셀의 각 요소를 들고 있는 구조체
    struct plantInitialModel{
        let plantImage : UIImage?
        let name : String
        let scientificName : String
    }
}

//MARK: ========검색 결과 리스트 table========
extension InfoSearchViewController: UITableViewDelegate, UITableViewDataSource{
    func setupTableView(){
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plantInitialData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? InfoSearchTableViewCell else {return UITableViewCell()}
        
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
        print("========== 식물 정보 조회 API ===========")
        //accessToken으로 kakao 유저 데이터 가져오기
        let url = baseurl + "/info/searchInfo"
        let header : HTTPHeaders = [
                   "Content-Type" : "application/json"
               ]
        
        
        let queryString : Parameters = ["name" : name]
        
        MyAlamofireManager.shared
            .session
            .request(url,method : .post, parameters: queryString, encoding: URLEncoding.queryString)
            .responseJSON(completionHandler: {response in
                print("========== debugPrint ===========")
                debugPrint(response)
                print("========== 식물 정보 조회 API ===========")
            })
                
        
        
        
        
//        .responseData { response in
//                        switch response.result {
//                        case .success(let res):
//                            do {
//                                print("====================================success")
//                                print(res)
//                                print("응답 데이터 :: ", String(data: res, encoding: .utf8) ?? "")
//
//
//                                let decoder = JSONDecoder()
//                                guard let decodedData = try? decoder.decode(InfoSearchModel.self, from: res) else {
//                                    print("decoded data test")
//                                    return
//                                }
//                                print(decodedData.result)
//
//                                for i in decodedData.result{
//                                    self.plantInitialData.append( plantInitialModel(plantImage: UIImage(named: "plant1"), name: i.name, scientificName: i.name))
//                                }
//                                print(self.plantInitialData)
//
//                            }
//                            catch (let err){
//                                print("")
//                                print("====================================")
//                                print("catch :: ", err.localizedDescription)
//                                print("====================================")
//                                print("")
//                            }
//                            break
//                        case .failure(let err):
//                            print("")
//                            print("====================================")
//                            print("응답 코드 :: ", response.response?.statusCode ?? 0)
//                            print("-------------------------------")
//                            print("에 러 :: ", err.localizedDescription)
//                            print("====================================")
//                            print("")
//                            break
//                        }
//                    }
//        print("========== 식물 정보 조회 API ===========")
    }
}

