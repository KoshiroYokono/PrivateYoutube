//
//  UIButton+extension.swift
//  TinderApp
//
//  Created by 横野公至郎 on 2020/01/24.
//  Copyright © 2020 横野公至郎. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func resizeImage() {
        imageView?.contentMode = .scaleAspectFit
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
