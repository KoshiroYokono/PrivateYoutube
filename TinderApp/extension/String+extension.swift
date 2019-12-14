//
//  String+extension.swift
//  TinderApp
//
//  Created by 横野公至郎 on 2019/11/16.
//  Copyright © 2019 横野公至郎. All rights reserved.
//

import Foundation

extension String {
    func urlEncode() -> String {
        return addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = .current
        let date = formatter.date(from: self)!
        return date
    }

}
