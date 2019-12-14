//
//  LoadingView.swift
//  TinderApp
//
//  Created by 横野公至郎 on 2019/11/22.
//  Copyright © 2019 横野公至郎. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    static func view() -> LoadingView {
        let view = UINib(nibName: String(describing: LoadingView.self), bundle: .main).instantiate(withOwner: self, options: nil).first as! LoadingView
        view.startAnimating()
        return view
    }
    
    func startAnimating() {
        indicatorView.startAnimating()
    }
    
}
