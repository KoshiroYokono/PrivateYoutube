//
//  YoutubeApiManager.swift
//  TinderApp
//
//  Created by 横野公至郎 on 2019/11/08.
//  Copyright © 2019 横野公至郎. All rights reserved.
//

import Foundation
import SwiftyJSON

class YoutubeApiManager {
    static let shared = YoutubeApiManager()
    private init() {}
    
    func fetchVideos(pageToken: String? = nil, handler: @escaping ModelHandler<VideoList>) {
        if let pageToken = pageToken {
            ApiClient.request(.sample,parameters: "&pageToken=\(pageToken)") { (result) in
                switch result {
                case .success(let json):
                    let videoList = VideoList(json: json)
                    handler(.success(videoList))
                case .failure(let error):
                    handler(.failure(.api(error)))
                }
            }
        } else {
            ApiClient.request(.sample) { (result) in
                switch result {
                case .success(let json):
                    let videoList = VideoList(json: json)
                    handler(.success(videoList))
                case .failure(let error):
                    handler(.failure(.api(error)))
                }
            }
        }
    }
    
    
    
    
}
