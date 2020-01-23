//
//  ApiDefinition.swift
//  TinderApp
//
//  Created by 横野公至郎 on 2019/11/16.
//  Copyright © 2019 横野公至郎. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

fileprivate let hostURL = "https://www.googleapis.com/youtube/v3"
fileprivate let apiKey = "AIzaSyAXuv29FfuDTnr75zQPC5TJJgGASscrchA"

enum Api {
    case search
    case sample
    case channel(String)
    
    var urlValue: String {
        switch self {
        case .search:
            return "/search?"
        case .sample:
            return "/search?part=snippet&channelId=UCpRTROg3nHnOWVPVeMq4z_w&order=date&maxResults=15"
        case .channel(let id):
             return "/channels?part=snippet&id=\(id)&fields=items(id,snippet(thumbnails))"
        }
    }
    
    var url: String {
        return (hostURL + urlValue + "&key=\(apiKey)").urlEncode()
    }
}

typealias ApiResultHandler = (_ result: ApiResult) -> Void

enum ApiResult {
    case success(JSON)
    case failure(ApiError)
}

enum ApiError: Error {
    case api(String)
    case http
    case offline
    
    var message: String {
        switch self {
        case .api(let message):
            return message
        default:
            return "ネットワーク接続に失敗しました。 \n 通信状況をご確認ください。"
        }
    }
}

