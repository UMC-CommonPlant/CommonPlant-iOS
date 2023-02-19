//
//  MemoViewController.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/02/12.
//

import UIKit
import Alamofire

class MemoViewController: UIViewController {

    
    var memoIdentifier: String = "memoListCell"
//    var memoReuseIdentifier: String = "memoReuseIdentifier"
    
    var plantToInt: Int = 4
    
    @IBOutlet weak var memoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData(plantIdx: plantToInt)
        setupTableView()
    }
    
    //custom cell 등록
//    private func registerXib() {
//        let nibName = UINib(nibName: memoIdentifier, bundle: nil)
//        memoCollectionView.register(nibName, forCellWithReuseIdentifier: memoReuseIdentifier)
//    }
    
    
    var MemoData:[MemoModel] = []
    
    //셀의 각 요소를 들고 있는 구조체
    struct MemoModel{
        let memoImage : String?
        let userImage : String?
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
    
    //========== 식물 정보 조회 API ===========
    func setData(plantIdx: Int){
        
        //accessToken으로 kakao 유저 데이터 가져오기
        let url = API.BASE_URL + "/plant/" + String(plantIdx) + "/memoList"
        var token = UserDefaults.standard.object(forKey: "token") as! String ?? ""
        let header : HTTPHeaders = [
            "Content-Type" : "application/json",
            "X-AUTH-TOKEN" : token
        ]
//        let queryString : Parameters = ["name" : name]
        
        MyAlamofireManager.shared
            .session
            .request(url,method : .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseJSON(completionHandler: {response in
                        
                        switch response.result{
                            
                            
                        case .success(let obj):
                            print("========== 테스트ㅡ으으으 ===========")

                            do{
                                let dataJson = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                                let jsonData = try JSONDecoder().decode(MemoListModel.self, from: dataJson)
                                print(jsonData)
                                var cnt = 0
                                for i in jsonData.result.memoCardDto{
                                    var data = jsonData.result.memoCardDto[cnt][0]
                                    self.MemoData.append(MemoModel(memoImage: data.imgURL, userImage: data.userImgURL, userName: data.userNickName, content: data.content, createdDate: data.createdAt))
                                    cnt+=1
                                }

                                self.memoTableView.reloadData()

                            }catch{
                                print(error.localizedDescription)
                            }
//
                            break
                        case .failure(let err):
                            debugPrint(err)
                            break
                        }
                    })
            }
    
    
    
}
