//
//  InfoViewController.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/11.
//

import UIKit



class InfoViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var popularResetTime: UILabel!
    @IBOutlet weak var popularTableView: UITableView!
    @IBOutlet weak var searchLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchLabel()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    
    //=======검색 후 다음 페이지로 넘김==========
    func setupSearchLabel(){
        self.searchLabel.delegate=self
    }
    
    var delegate: TextFieldSearchDelegate?
    

    
    //UITextDelegate return key 이벤트 함수 -> 엔터 눌렀을 때 검색 이벤트
    func textFieldReturn(_ textField : UITextField) -> Bool{
        if textField == self.searchLabel{
            //액션 지정
            
        }
        return true
    }
    
    
    
    
    //=======인기검색어=======
    //인기 검색어 table view setup
    func setupTableView(){
        popularTableView.delegate = self
        popularTableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plantInitialData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlantTableViewCell", for: indexPath) as? PlantTableViewCell else {return UITableViewCell()}
        
        let item = plantInitialData[indexPath.row]
        cell.setupData(
            item.plantImage,
            item.name,
            item.scientificName,
            item.lastMonthCount
        )
        return cell
    }
    

    //데이터 모델
    let plantInitialData:[plantInitialModel] = [
        plantInitialModel(plantImage: UIImage(named: "InfoPlantImg"), name: "몬스테라", scientificName: "Monstera", lastMonthCount: "지난달 100명이 검색"),
        plantInitialModel(plantImage: UIImage(named: "InfoPlantImg"), name: "몬스테라", scientificName: "Monstera", lastMonthCount: "지난달 100명이 검색"),
        plantInitialModel(plantImage: UIImage(named: "InfoPlantImg"), name: "몬스테라", scientificName: "Monstera", lastMonthCount: "지난달 100명이 검색"),
        plantInitialModel(plantImage: UIImage(named: "InfoPlantImg"), name: "몬스테라", scientificName: "Monstera", lastMonthCount: "지난달 100명이 검색"),
        plantInitialModel(plantImage: UIImage(named: "InfoPlantImg"), name: "몬스테라", scientificName: "Monstera", lastMonthCount: "지난달 100명이 검색")
    ]
    
    //셀의 각 요소를 들고 있는 구조체
    struct plantInitialModel{
        let plantImage : UIImage?
        let name : String
        let scientificName : String
        let lastMonthCount : String
    }

}
