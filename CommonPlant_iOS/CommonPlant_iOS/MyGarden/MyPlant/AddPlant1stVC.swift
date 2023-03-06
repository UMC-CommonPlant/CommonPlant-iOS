//
//  AddPlant1stVC.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/02/13.
//

import UIKit
import Alamofire
import Kingfisher

class AddPlant1stVC: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchInputLabel: UITextField!
    
    var cellIdentifier: String = "addPlantIdentifier"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchLabel()
        setupTableView()
    }
    var plantData:[plantModel] = [ ]
    
    struct plantModel{
        let imgUrl : String
        let name : String
        let scientificName : String
    }
 
}

//MARK: =======검색 후 결과 불러오기==========
extension AddPlant1stVC: UITextFieldDelegate {
    func setupSearchLabel() {
        self.searchInputLabel.delegate = self
    }
    
    //UITextDelegate return key 이벤트 함수 -> 엔터 눌렀을 때 검색 이벤트
    func textFieldShouldReturn(_ textField : UITextField) -> Bool {

        textField.resignFirstResponder()
        
        if textField == self.searchInputLabel {
            print(textField)
            setData(name: textField.text ?? "")
        }

        return true
    }
}

extension AddPlant1stVC: UITableViewDelegate, UITableViewDataSource {
        func setupTableView(){
            searchTableView.delegate = self
            searchTableView.dataSource = self
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return plantData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? AddPlant1stTVC else {return UITableViewCell()}
            
            let item = plantData[indexPath.row]
            
            cell.setupData(
                item.imgUrl,
                item.name,
                item.scientificName
            )
            
            cell.selectionStyle = .none
            return cell
        }
    
    
    func setData(name: String){
        self.plantData.removeAll()
        let url = API.BASE_URL + "/info/searchInfo"
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
                                
                                for i in jsonData.result{
                                    print(i.name)
                                    self.plantData.append(plantModel(imgUrl: i.imgURL, name: i.name, scientificName: i.scientificName))
                                }
                                print(self.plantData.count)
                                
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
