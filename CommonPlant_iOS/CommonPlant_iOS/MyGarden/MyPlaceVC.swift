//
//  MyPlaceViewController.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/01/29.
//

import UIKit

class MyPlaceVC: UIViewController {

    @IBOutlet weak var mainTopView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var myPlantArray = ["몬테", "카스테라"]
    var dDayArray = ["D-3","D-5"]
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpTopView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 24))
        
        navigationController?.isNavigationBarHidden = false

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setUpTopView() {
        mainTopView.layer.shadowColor = UIColor(red: 0.204, green: 0.204, blue: 0.204, alpha: 1).cgColor
        mainTopView.layer.shadowOpacity = 0.3
        mainTopView.layer.shadowRadius = 7
        mainTopView.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 199, width: mainTopView.bounds.width, height: 5)).cgPath
    }
}

extension MyPlaceVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return myPlantArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPlaceTableViewCell", for: indexPath) as! MyPlaceTableViewCell? else {
            return UITableViewCell()
        }
        
        if indexPath.row != 0 {
            cell.waterBtn.layer.isHidden = true
            cell.dDayLabel.textColor = UIColor(named: "Gray4")
        }
        
        cell.myPlantNameLabel.text = myPlantArray[indexPath.row]
        cell.dDayLabel.text = dDayArray[indexPath.row]
        cell.selectionStyle = .none
        
        cell.myPlaceContentView.layer.cornerRadius = 16
        cell.myPlaceContentView.layer.borderWidth = 0.5
        cell.myPlaceContentView.layer.borderColor = UIColor(red: 0.879, green: 0.879, blue: 0.879, alpha: 1).cgColor

        cell.myPlaceContentView.layer.shadowColor = UIColor(red: 0.471, green: 0.471, blue: 0.471, alpha: 0.25).cgColor
        cell.myPlaceContentView.layer.shadowOpacity = 1
        cell.myPlaceContentView.layer.shadowRadius = 4
        cell.myPlaceContentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        cell.myPlaceContentView.layer.masksToBounds = false
        
        cell.plantImg.layer.cornerRadius = 16
        return cell
    }
}
