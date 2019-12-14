//
//  Movie.swift
//  TinderApp
//
//  Created by 横野公至郎 on 2019/11/16.
//  Copyright © 2019 横野公至郎. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

struct ID {
    let kind:String
    let videoId:String
    
    init(kind:String,videoId:String) {
        self.kind = kind
        self.videoId = videoId
    }
}

struct ThumbNail {
    let height: CGFloat
    let width: CGFloat
    let url:URL
    
    enum ThumbNailType {
        case defaultSize
        case high
        case medium
        
        var string:String {
            switch self {
            case .defaultSize:
                return "defaultSize"
            case .high:
                return "high"
            case .medium:
                return "medium"
            }
        }
    }
    
    init?(json: JSON) {
        guard
            let height = json["height"].int,
            let url = json["url"].url,
            let width = json["width"].int else {
                return nil
        }
        self.height = CGFloat(height)
        self.url = url
        self.width = CGFloat(width)
    }
}

struct Movie {
    let videoId:String
    let kind:String?
    let channelId:String
    let channelTitle:String
    let description:String
    let liveBroadcastContent:String?
    let publishedAt:Date
    let thumbnailDefault:ThumbNail
    let thumbnailHigh:ThumbNail
    let thumbnailMedium:ThumbNail
    let title:String
    
    init?(json:JSON) {
        guard
            let videoId = json["id"]["videoId"].string,
            let channelId = json["snippet"]["channelId"].string,
            let channelTitle = json["snippet"]["channelTitle"].string,
            let description = json["snippet"]["description"].string,
            let publishedAt = json["snippet"]["publishedAt"].string,
            let defaultThumb = ThumbNail(json: json["snippet"]["thumbnails"]["default"]),
            let highThumb = ThumbNail(json: json["snippet"]["thumbnails"]["high"]),
            let mediumThumb = ThumbNail(json: json["snippet"]["thumbnails"]["medium"]),
            let title = json["snippet"]["title"].string
            else {
                return nil
        }
        let kind = json["kind"].string
        let liveBroadCastContent = json["snnipet"]["liveBroadcastContent"].string
        self.videoId = videoId
        self.kind = kind
        self.channelId = channelId
        self.channelTitle = channelTitle
        self.description = description
        self.liveBroadcastContent = liveBroadCastContent
        self.publishedAt = publishedAt.toDate()
        self.thumbnailDefault = defaultThumb
        self.thumbnailHigh = highThumb
        self.thumbnailMedium = mediumThumb
        self.title = title
    }
}
