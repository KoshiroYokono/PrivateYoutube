//
//  NavigationFooterView.swift
//  TinderApp
//
//  Created by 横野公至郎 on 2019/11/22.
//  Copyright © 2019 横野公至郎. All rights reserved.
//

import UIKit

class NavigationFooterView: UIView {
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var channelButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let buttons:[UIButton] = [homeButton,historyButton,channelButton]
        buttons.forEach { (button) in
            resizeImage(button: button)
        }
    }
    
    private func resizeImage(button: UIButton) {
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 10)
    }
    
    static func view() -> NavigationFooterView {
        let view = UINib(nibName: String(describing: NavigationFooterView.self), bundle: .main).instantiate(withOwner: self, options: nil).first as! NavigationFooterView
        return view
    }
}
