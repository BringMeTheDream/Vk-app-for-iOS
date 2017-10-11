//
//  newsModel.swift
//  vk
//
//  Created by Андрей Коноплев on 10.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import Foundation

class PostInfo {
    let type: String
    let likeCount: Int
    let repostsCount: Int
    let dateUpload: Int
    let source_id: Int
    let text: String
    
    var attachements: PostAttachments?

    init(type: String, likeCount: Int, repostsCount: Int, dateUpload: Int, source_id: Int, text: String) {
        self.type = type
        self.likeCount = likeCount
        self.repostsCount = repostsCount
        self.dateUpload = dateUpload
        self.source_id = source_id
        self.text = text
    }
}

class PostAttachments {
    let type: String
    let source_url: String
    let width: Int
    let height: Int
    
    init(type: String, source_url: String, width: Int, height: Int) {
        self.type = type
        self.source_url = source_url
        self.width = width
        self.height = height
    }
    
}
