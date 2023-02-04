//
//  AddPlaceViewController.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/02/02.
//

import UIKit

class AddPlaceVC: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addressBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        textFieldUnderline()
        buttonUnderLine()
    }
    
    func textFieldUnderline() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 1, width: textField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor(named: "Gray2")?.cgColor
        textField.borderStyle = UITextField.BorderStyle.none
        textField.layer.addSublayer(bottomLine)
    }
    
    func buttonUnderLine() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: addressBtn.frame.height - 1, width: addressBtn.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor(named: "Gray2")?.cgColor
        addressBtn.layer.addSublayer(bottomLine)
    }
 

}
