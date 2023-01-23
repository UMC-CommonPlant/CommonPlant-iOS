//
//  InfoViewController.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/11.
//

import UIKit



//class InfoViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,
//                          UICollectionViewDelegate, UICollectionViewDataSource{

class InfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var searchTextFieldIdentifire = "searchTextFieldIdentifire"
    var collectionViewCellIdentifire = "collectionViewCellIdentifire"

    @IBOutlet weak var popularResetTime: UILabel!
    @IBOutlet weak var popularTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchLabel()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    
    //=======검색 후 다음 페이지로 넘김==========
    func setupSearchLabel(){
//        self.searchTextField.delegate=self
    }
    
    var delegate: TextFieldSearchDelegate?
    

    
    //UITextDelegate return key 이벤트 함수 -> 엔터 눌렀을 때 검색 이벤트
//    func textFieldShouldReturn(_ textField : UITextField) -> Bool{
//
//        guard let result = self.storyboard?.instantiateViewController(withIdentifier: "InfoSearchViewController") as? InfoSearchViewController else{
//            return true
//        }
//        result.textToSet = searchTextField.text
//        self.present(result, animated: false)
//
//        return true
//    }


    //=======카테고리 컬렉션 뷰========
//    func setupCollectionView(){
//
//    }
//
//    private let cellWidth: CGFloat = 101
//    private let cellHeight: CGFloat = 76
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return categoryData.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
    
    
    
    
    
    
    
    
    
    
    let categoryData:[categoryInitialModel] = [
        categoryInitialModel(categoryImage: UIImage(named: "InfoPlantImg"), name: "원룸"),
        categoryInitialModel(categoryImage: UIImage(named: "InfoPlantImg"), name: "공기정화"),
        categoryInitialModel(categoryImage: UIImage(named: "InfoPlantImg"), name: "초보집사"),
        categoryInitialModel(categoryImage: UIImage(named: "InfoPlantImg"), name: "채광"),
        categoryInitialModel(categoryImage: UIImage(named: "InfoPlantImg"), name: "물 좋아함"),
        categoryInitialModel(categoryImage: UIImage(named: "InfoPlantImg"), name: "인테리어"),
    ]
    
    struct categoryInitialModel{
        let categoryImage : UIImage?
        let name : String
    }
    
    //=======인기검색어=======
    //인기 검색어 table view setup
    func setupTableView(){
        popularTableView.delegate = self
        popularTableView.dataSource = self
    }
    
    //table view row 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plantInitialData.count
    }
    
    //table view에 넘겨줄 데이터
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //dequeue 재사용
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlantTableViewCell", for: indexPath) as? PlantTableViewCell else {return UITableViewCell()}
        
        //cell에 들어갈 내용 정의
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
