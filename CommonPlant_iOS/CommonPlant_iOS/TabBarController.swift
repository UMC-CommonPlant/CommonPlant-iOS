//
//  TabBarController.swift
//  CommonPlant_iOS
//
//  Created by 이예원 on 2023/01/21.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        UITabBar.appearance()
    }
    
}

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits =  super.sizeThatFits(size)
        sizeThatFits.height = 64
        return sizeThatFits
    }
}
