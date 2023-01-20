//
//  InfoViewController.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/11.
//

import UIKit



class InfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource{

    

//class InfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var searchTextFieldIdentifire = "searchTextFieldIdentifire"
    var collectionViewCellIdentifire = "collectionViewCell"

    @IBOutlet weak var popularResetTime: UILabel!
    @IBOutlet weak var popularTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
 
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchLabel()
        setupCollectionView()
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
    func setupCollectionView(){
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
//        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        flowLayout.itemSize = CGSize(width: 100, height: 100)
//        categoryCollectionView.collectionViewLayout = flowLayout
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : PlantCollectionViewCell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: self.collectionViewCellIdentifire, for: indexPath) as! PlantCollectionViewCell
        
        let item = categoryData[indexPath.row]
        cell.setupData(
            item.categoryImage,
            item.title,
            item.color
        )
        
        return cell
    }
    
    
    
    let categoryData:[categoryInitialModel] = [
        categoryInitialModel(categoryImage: UIImage(named: "InfoCategory1"), title: "원룸", color: UIColor(named: "infoCategoryColor1")),
        categoryInitialModel(categoryImage: UIImage(named: "InfoCategory2"), title: "공기정화", color: UIColor(named: "infoCategoryColor2")),
        categoryInitialModel(categoryImage: UIImage(named: "InfoCategory3"), title: "초보집사", color: UIColor(named: "infoCategoryColor3")),
        categoryInitialModel(categoryImage: UIImage(named: "InfoCategory4"), title: "채광", color: UIColor(named: "infoCategoryColor4")),
        categoryInitialModel(categoryImage: UIImage(named: "InfoCategory5"), title: "물 좋아함", color: UIColor(named: "infoCategoryColor5")),
        categoryInitialModel(categoryImage: UIImage(named: "InfoCategory6"), title: "인테리어", color: UIColor(named: "infoCategoryColor6")),
    ]
    
    struct categoryInitialModel{
        let categoryImage : UIImage?
        let title : String
        let color : UIColor?
    }
    
    //=======카테고리 컬렉션 선택시 다음 화면으로 데이터 넘기기========
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController: InfoRecoViewController = segue.destination as? InfoRecoViewController else{
            return
        }
        
        guard let cell: PlantCollectionViewCell = sender as? PlantCollectionViewCell else {
            return
        }
        
        nextViewController.recoText = cell.titleLabel?.text
        nextViewController.recoColor = cell.categoryView?.backgroundColor
        nextViewController.recoImage = cell.categoryImageView?.image
        
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
