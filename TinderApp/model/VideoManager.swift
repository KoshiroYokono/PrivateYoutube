//
//  VideoManager.swift
//  TinderApp
//
//  Created by 横野公至郎 on 2020/01/04.
//  Copyright © 2020 横野公至郎. All rights reserved.
//

import Foundation

class VideoManager {
    static let shared = VideoManager()
    private init() {}
    
    func incrementViewCount(videoId: String) {
        if var viewCount = UserDefaults.videoPlayCount[videoId] {
            viewCount+=1
            UserDefaults.videoPlayCount[videoId] = viewCount
        } else {
            UserDefaults.videoPlayCount[videoId] = 1
        }
    }
    
    func viewCount(videoId: String) -> Int {
        if let count = UserDefaults.videoPlayCount[videoId] {
            return count
        }
        return 0
    }
    
    func isVideoLiked(videoId: String) -> Bool {
        return UserDefaults.likedVideos.contains(videoId)
    }
    
    func removeLike(videoId: String) {
        var likeVideos = UserDefaults.likedVideos
        if let index = likeVideos.firstIndex(of: videoId) {
            likeVideos.remove(at: index)
        }
        UserDefaults.likedVideos = likeVideos
    }
    
    func addLike(videoId: String) {
        var likeVideos = UserDefaults.likedVideos
        likeVideos.append(videoId)
        UserDefaults.likedVideos = likeVideos
    }
}
