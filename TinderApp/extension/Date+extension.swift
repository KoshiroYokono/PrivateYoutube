//
//  Date+extension.swift
//  TinderApp
//
//  Created by 横野公至郎 on 2019/11/22.
//  Copyright © 2019 横野公至郎. All rights reserved.
//

import Foundation

extension Date {
    
    enum Templete: String {
        case date = "yyyy年MM月dd日"
    }
    
    func toString(templete: Templete) -> String {
        let f = DateFormatter()
        f.dateFormat = DateFormatter.dateFormat(fromTemplate: templete.rawValue, options: 0, locale: .current)
        let date = f.string(from: self)
        return date
    }
    
}
