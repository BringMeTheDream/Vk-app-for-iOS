//
//  newsModel.swift
//  vk
//
//  Created by Андрей Коноплев on 10.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class PostInfo {
    let type: String
    let likeCount: Int
    let repostsCount: Int
    let dateUpload: Int
    let owner_id: Int
    let text: String
    
    var attachements: PostAttachments?
    var author_name: String?
    var author_photo_url: String?

    init(type: String, likeCount: Int, repostsCount: Int, dateUpload: Int, owner_id: Int, text: String) {
        self.type = type
        self.likeCount = likeCount
        self.repostsCount = repostsCount
        self.dateUpload = dateUpload
        self.owner_id = owner_id
        self.text = text
    }
}

class PostAttachments {
    let type: String
    let source_url: String
    var size: CGSize?
    
    init(type: String, source_url: String) {
        self.type = type
        self.source_url = source_url
    
    }
    
}

