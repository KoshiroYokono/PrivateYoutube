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

enum Api: String {
    case search = "/search?"
    case sample = "/search?part=snippet&channelId=UCpRTROg3nHnOWVPVeMq4z_w&order=date&maxResults=15"
    
    var url: String {
        return (hostURL + rawValue + "&key=\(apiKey)").urlEncode()
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

