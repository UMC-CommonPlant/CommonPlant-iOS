//
//  NicknameViewController.swift
//  CommonPlant_iOS
//
//  Created by 다현 on 2023/01/17.
//

import UIKit

class NicknameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goagree(_ sender: Any) {
        //로그인 화면의 storyboard ID를 참조하여 뷰 컨트롤러를 가져오기
        guard let agree = self.storyboard?.instantiateViewController(withIdentifier: "AgreeView") else {
            return
        }
        //화면 전환 애니메이션을 설정
        agree.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        
        //인자값으로 다음 뷰 컨트롤러를 넣고 present 메소드를 호출
        self.present(agree, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
