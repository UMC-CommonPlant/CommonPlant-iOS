//
//  InfoDetailViewController.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/01/18.
//

import UIKit

class InfoDetailViewController: UIViewController {
    
    var textToSet: String?
    
    @IBOutlet weak var textLabel : UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.textLabel.text = self.textToSet
        print(textToSet)
    }
    

}
