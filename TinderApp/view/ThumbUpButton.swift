//
//  ThumbUpButton.swift
//  TinderApp
//
//  Created by 横野公至郎 on 2020/01/04.
//  Copyright © 2020 横野公至郎. All rights reserved.
//

import UIKit

class ThumbUpButton: UIButton {
    override var isSelected: Bool {
        didSet {
            if isSelected {
                setImage(#imageLiteral(resourceName: "thumbUpBlue"), for: .normal)
            } else {
                setImage(#imageLiteral(resourceName: "thumbUp"), for: .normal)
            }
        }
    }
}
