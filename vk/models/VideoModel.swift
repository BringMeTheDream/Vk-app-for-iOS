//
//  VideoModel.swift
//  vk
//
//  Created by Андрей Коноплев on 27.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class VideoModel {
    let id: Int
    let title: String
    let duration: Int
    let description: String
    let date: Int
    let views: Int
    let photo_url: String
    let video_url: String
    
    init(id: Int, title: String, duration: Int, description: String, date: Int, views: Int, photo_url: String, video_url: String) {
        self.id = id
        self.title = title
        self.duration = duration
        self.description = description
        self.date = date
        self.views = views
        self.photo_url = photo_url
        self.video_url = video_url
    }
}
