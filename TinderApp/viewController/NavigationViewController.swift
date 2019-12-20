//
//  NavigationViewController.swift
//  TinderApp
//
//  Created by 横野公至郎 on 2019/11/17.
//  Copyright © 2019 横野公至郎. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
    }
    
    func setUpNavigationBar() {
        navigationBar.isTranslucent = false
        let titleView = UIImageView(image: #imageLiteral(resourceName: "youtube"))
        titleView.contentMode = .scaleAspectFit
        navigationBar.topItem?.titleView = titleView
        navigationBar.backgroundColor = .white
    }
}
