//
//  MemoViewController.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/02/12.
//

import UIKit

class MemoViewController: UIViewController {

    
    var memoIdentifier: String = "memoListCell"
//    var memoReuseIdentifier: String = "memoReuseIdentifier"
    
    @IBOutlet weak var memoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        registerXib()
        setupTableView()
    }
    
    //custom cell 등록
//    private func registerXib() {
//        let nibName = UINib(nibName: memoIdentifier, bundle: nil)
//        memoCollectionView.register(nibName, forCellWithReuseIdentifier: memoReuseIdentifier)
//    }
    
    
    let MemoData:[MemoModel] = [
        MemoModel(memoImage: UIImage(named: "plant1"), userImage: UIImage(named: "plant1"), userName: "커먼플랜트", content: "오늘 잎이 좀 시들하구나 커먼아 해결책은?", createdDate: "2022.11.20"),
        MemoModel(memoImage: nil, userImage: UIImage(named: "plant1"), userName: "커먼플랜트", content: "장마여서 물 주는 날짜를 조금 늦춤, 하지만 해는 맑구나 몬테랑 함께한 지 벌써 56일이 되었구나 요즘 잎이 갈라지니 채광이 더 드는 곳으로 자리를 옮겨야 할 것 같아.", createdDate: "2022.11.20"),
        MemoModel(memoImage: nil, userImage: UIImage(named: "plant1"), userName: "커먼플랜트", content: "오늘 잎이 좀 시들하구나 커먼아 해결책은?", createdDate: "2022.11.20"),
        MemoModel(memoImage: UIImage(named: "plant1"), userImage: UIImage(named: "plant1"), userName: "커먼플랜트", content: "장마여서 물 주는 날짜를 조금 늦춤, 하지만 해는 맑구나 몬테랑 함께한 지 벌써 56일이 되었구나 요즘 잎이 갈라지니 채광이 더 드는 곳으로 자리를 옮겨야 할 것 같아.", createdDate: "2022.11.20"),
        MemoModel(memoImage: UIImage(named: "plant1"), userImage: UIImage(named: "plant1"), userName: "커먼플랜트", content: "장마여서 물 주는 날짜를 조금 늦춤, 하지만 해는 맑구나 몬테랑 함께한 지 벌써 56일이 되었구나 요즘 잎이 갈라지니 채광이 더 드는 곳으로 자리를 옮겨야 할 것 같아.", createdDate: "2022.11.20")
    ]
    
    //셀의 각 요소를 들고 있는 구조체
    struct MemoModel{
        let memoImage : UIImage?
        let userImage : UIImage?
        let userName : String
        let content : String
        let createdDate : String
    }


}
extension MemoViewController: UITableViewDelegate, UITableViewDataSource{

    
    func setupTableView(){
        memoTableView.delegate = self
        memoTableView.dataSource = self

        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero

        var margin: Int = 16
        var width:CGFloat = UIScreen.main.bounds.width
        var height: CGFloat = width * 0.7524
        print("========collection view==========",width,"  ",height)
        print("========collection view bound==========",memoTableView.bounds.width," ",memoTableView.bounds.height)
        print("========collection==========",UIScreen.main.bounds.width,"  ",UIScreen.main.bounds.height)

        flowLayout.itemSize = CGSize(width: width, height: height)
//        memoTableView. = flowLayout
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MemoTableViewCell = memoTableView.dequeueReusableCell(withIdentifier: self.memoIdentifier, for: indexPath) as! MemoTableViewCell

        let item = MemoData[indexPath.row]
        cell.setupData(
            item.memoImage,
            item.userImage,
            item.userName,
            item.content,
            item.createdDate
        )
        return cell
    }
}
