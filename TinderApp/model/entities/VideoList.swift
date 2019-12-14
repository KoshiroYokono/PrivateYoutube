//
//  VideoList.swift
//  TinderApp
//
//  Created by 横野公至郎 on 2019/11/22.
//  Copyright © 2019 横野公至郎. All rights reserved.
//

import Foundation
import SwiftyJSON

struct VideoList {
    var videos: [Movie]
    var nextPageToken: String
    var totalCount: Int
    
    init?(json: JSON) {
        let videos = json["items"].arrayValue.compactMap({Movie(json: $0)})
        guard
            !videos.isEmpty,
            let nextPageToken = json["nextPageToken"].string,
            let  totalCount = json["pageInfo"]["totalResults"].int else {
                print("niltでした＝＝＝＝")
            return nil
        }
        self.videos = videos
        self.nextPageToken = nextPageToken
        self.totalCount = totalCount
    }
}
