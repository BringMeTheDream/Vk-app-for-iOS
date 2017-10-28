//
//  VideoListManager.swift
//  vk
//
//  Created by Андрей Коноплев on 27.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import SwiftyJSON

class VideoListManager {
    static func getVideoListManager(user_id: Int, success: @escaping (_ videoArray: [VideoModel])-> Void) {
        _ = API_wrapper.getVideoList(user_id: user_id, success: { (response) in
            let jsonResponse = JSON(response)
            let arrayOfVideos = jsonResponse["response"]["items"].arrayValue
            var videosArray = [VideoModel]()
            for item in arrayOfVideos {
                let id = item["id"].intValue
                let title = item["title"].stringValue
                let duration = item["duration"].intValue
                let description = item["description"].stringValue
                let date = item["date"].intValue
                let views = item["views"].intValue
                let photo_url = item["photo_130"].stringValue
                let video_url = item["player"].stringValue
                
                videosArray.append(VideoModel(id: id, title: title, duration: duration, description: description, date: date, views: views, photo_url: photo_url, video_url: video_url))
            }
            
            success(videosArray)
        }, failure: { (error) in
            print(error)
        })
    }
}
