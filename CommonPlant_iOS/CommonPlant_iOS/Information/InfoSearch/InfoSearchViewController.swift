//
//  InfoSearchViewController.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/16.
//

import UIKit

protocol TextFieldSearchDelegate{
    func onChange(text: String)
}

class InfoSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var textToSet: String!

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchInputLabel: UITextField!
    
    let cellIdentifier: String = "infoSearchCell"
//    let performSegueIdentifire: String = "infoSearchPerformSegue"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //이전의 검색 텍스트 받아오기
        self.searchInputLabel.text = textToSet
        setupTableView()
//        performSegue(withIdentifier: self.performSegueIdentifire, sender: nil)
        // Do any additional setup after loading the view.
    }
    
    
//    func onChange(text: String){
//        searchInputLabel.text = text
//    }
    
    
    
    //InfoDetailViewController의 textLabel로 데이터 넘기기
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let nextViewController: InfoDetailViewController = segue.destination as? InfoDetailViewController else{
            return
        }
        
        guard let cell: InfoSearchTableViewCell = sender as? InfoSearchTableViewCell else {
            return
        }
        
        nextViewController.textToSet = cell.nameLabel?.text
    }


    
    
    
    
    //========검색 결과 리스트 table========
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
    

    //데이터 모델
    let plantInitialData:[plantInitialModel] = [
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
