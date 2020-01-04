//
//  UserDefault+extension.swift
//  TinderApp
//
//  Created by 横野公至郎 on 2020/01/04.
//  Copyright © 2020 横野公至郎. All rights reserved.
//

import Foundation

extension UserDefaults {
    private static let videoPlayCountKey = "videoPlayCount"
    private static let likedVideosKey = "likedVideos"
    
    static var videoPlayCount:[String:Int] {
        get {
            if let videoPlayCount = UserDefaults.standard.dictionary(forKey: videoPlayCountKey) as? [String:Int]{
                return videoPlayCount
            }
            return [:]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: videoPlayCountKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var likedVideos: [String] {
        get {
            if let videos = UserDefaults.standard.object(forKey: likedVideosKey) as? [String] {
                return videos
            }
            return []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: likedVideosKey)
            UserDefaults.standard.synchronize()
        }
    }
}
