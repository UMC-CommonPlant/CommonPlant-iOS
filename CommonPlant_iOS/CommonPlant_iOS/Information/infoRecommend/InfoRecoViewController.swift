//
//  InfoRecoViewController.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/23.
//

import UIKit

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
    let plantInitialData:[plantInitialModel] = [
        plantInitialModel(plantImage: UIImage(named: "plant1"), name: "몬스테라", scientificName: "Monstera"),
        plantInitialModel(plantImage: UIImage(named: "plant2"), name: "몬스테라 알보 바리에가타", scientificName: "Monstera deliciosa"),
        plantInitialModel(plantImage: UIImage(named: "plant3"), name: "몬스테라 보르시지아나", scientificName: "Monstera"),
        plantInitialModel(plantImage: UIImage(named: "plant4"), name: "무늬 몬스테라", scientificName: "Monstera"),
        plantInitialModel(plantImage: UIImage(named: "plant5"), name: "몬스테라 델리오사", scientificName: "Monstera deliciosa"),
        plantInitialModel(plantImage: UIImage(named: "plant6"), name: "몬스테라", scientificName: "Monstera")
    ]
    
    //셀의 각 요소를 들고 있는 구조체
    struct plantInitialModel{
        let plantImage : UIImage?
        let name : String
        let scientificName : String
    }
}

//MARK: ======info 메인에서 카테고리 정보 넘겨받기======
extension InfoRecoViewController: UITableViewDelegate, UITableViewDataSource{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switch self.recoText{
        case "물":
            self.recoLabel.text = "물 좋아함"
            break
        case "채광":
            self.recoLabel.text = "음지식물"
            break
        default:
            self.recoLabel.text = self.recoText
        }
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
}
