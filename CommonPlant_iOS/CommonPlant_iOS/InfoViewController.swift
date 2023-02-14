//
//  InfoViewController.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/11.
//

import UIKit
import Alamofire

class InfoViewController: UIViewController{

    
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
        setData()
    }
    
    //=======collection & table 다음화면으로 데이터 넘기기=======
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //카테고리 컬렉션 선택시 InfoRecoViewController 화면으로 데이터 넘기기
        if segue.destination is InfoRecoViewController{
            //카테고리 컬렉션 선택
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
        
        //인기검색어 클릭시 info detail 화면으로 데이터 넘기기
        else{
            guard let nextViewController :InfoDetailViewController = segue.destination as? InfoDetailViewController else{
                return
            }
            guard let cell: PlantTableViewCell = sender as? PlantTableViewCell else{
                return
            }
            nextViewController.textToSet = cell.nameLabel?.text
        }
    }
    
    //category 데이터모델
    let categoryData:[categoryInitialModel] = [
        categoryInitialModel(categoryImage: UIImage(named: "InfoCategory1"), title: "원룸", color: UIColor(named: "infoCategoryColor1")),
        categoryInitialModel(categoryImage: UIImage(named: "InfoCategory2"), title: "공기정화", color: UIColor(named: "infoCategoryColor2")),
        categoryInitialModel(categoryImage: UIImage(named: "InfoCategory3"), title: "초보집사", color: UIColor(named: "infoCategoryColor3")),
        categoryInitialModel(categoryImage: UIImage(named: "InfoCategory4"), title: "채광", color: UIColor(named: "infoCategoryColor4")),
        categoryInitialModel(categoryImage: UIImage(named: "InfoCategory5"), title: "물", color: UIColor(named: "infoCategoryColor5")),
        categoryInitialModel(categoryImage: UIImage(named: "InfoCategory6"), title: "인테리어", color: UIColor(named: "infoCategoryColor6")),
    ]
    
    struct categoryInitialModel{
        let categoryImage : UIImage?
        let title : String
        let color : UIColor?
    }
    
    //table 데이터 모델
    var plantInitialData:[plantInitialModel] = [
//        plantInitialModel(plantImage: UIImage(named: "plant1"), name: "몬스테라", scientificName: "Monstera", lastMonthCount: "지난달 107명이 검색"),
//        plantInitialModel(plantImage: UIImage(named: "plant2"), name: "몬스테라 델리시오사", scientificName: "Monstera", lastMonthCount: "지난달 84명이 검색"),
//        plantInitialModel(plantImage: UIImage(named: "plant3"), name: "몬스테라 알보 바리에가타", scientificName: "Monstera", lastMonthCount: "지난달 52명이 검색"),
//        plantInitialModel(plantImage: UIImage(named: "plant4"), name: "몬스테라", scientificName: "Monstera deliociosa", lastMonthCount: "지난달 100명이 검색"),
//        plantInitialModel(plantImage: UIImage(named: "plant5"), name: "델리시오사", scientificName: "Monstera", lastMonthCount: "지난달 100명이 검색")
    ]
    
    //셀의 각 요소를 들고 있는 구조체
    struct plantInitialModel{
        let plantImage : String!
        let name : String
        let scientificName : String
        let lastMonthCount : String
    }
    
}
//MARK: =======검색 후 다음 페이지로 넘김==========
extension InfoViewController: UITextFieldDelegate{
    func setupSearchLabel(){
        self.searchTextField.delegate = self
    }
    
    //UITextDelegate return key 이벤트 함수 -> 엔터 눌렀을 때 검색 이벤트
    func textFieldShouldReturn(_ textField : UITextField) -> Bool{

        print("hello")
        textField.resignFirstResponder()
        
        if textField == self.searchTextField {
            
            print(self.searchTextField.text)
            guard let result = self.storyboard?.instantiateViewController(withIdentifier: "InfoSearchViewController") as? InfoSearchViewController else{
                return true
            }
            print(self.searchTextField.text)
            result.textToSet = self.searchTextField.text ?? ""
//            self.present(result, animated: false)
            self.navigationController?.pushViewController(result, animated: true)
        }
        print("test")

        return true
    }
}

//MARK: =======카테고리 컬렉션 뷰========
extension InfoViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func setupCollectionView(){
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        
        var margin: Int = 16
        var width:CGFloat = (UIScreen.main.bounds.width - 32 - 40 ) / 3.0
        var height: CGFloat = width * 0.7524
        print("========collection view==========",width,"  ",height)
        print("========collection view bound==========",categoryCollectionView.bounds.width," ",categoryCollectionView.bounds.height)
        print("========collection==========",UIScreen.main.bounds.width,"  ",UIScreen.main.bounds.height)

        flowLayout.itemSize = CGSize(width: width, height: height)
        categoryCollectionView.collectionViewLayout = flowLayout
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
}

//MARK: =======인기검색어 table=======
extension InfoViewController: UITableViewDelegate, UITableViewDataSource{
    
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
        
        cell.contentView.clipsToBounds = false
        
        cell.selectionStyle = .none
        return cell
    }
    
    func setData(){
        self.plantInitialData.removeAll()
        //accessToken으로 kakao 유저 데이터 가져오기
        let url = API.BASE_URL + "/word/getWordList"
        let header : HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        MyAlamofireManager.shared
            .session
            .request(url,method : .get, parameters: nil, encoding: URLEncoding.queryString)
            .responseJSON(completionHandler: {response in
                        
                        switch response.result{
                            
                            
                        case .success(let obj):
                            print("========== 테스트ㅡ으으으 ===========")

                            do{
                                let dataJson = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                                let jsonData = try JSONDecoder().decode(InfoPopularSearchModel.self, from: dataJson)
                                print(jsonData)
                                
//                                DispatchQueue.global().async { [weak self] in
                                for i in 0...5{
                                    var data = jsonData.result[i]
                                    self.plantInitialData.append(plantInitialModel(plantImage: data.imgURL, name: data.name, scientificName: data.scientificName, lastMonthCount: String(data.searchedNumber)+"명이 검색"))
                                    
                                }
                                
                                self.popularTableView.reloadData()
                                
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
