//
//  PhotoModel.swift
//  vk
//
//  Created by Андрей Коноплев on 23.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class PhotoModel {
    let url: String
    let owner_id: Int
    let date: Int
    let size: CGSize
    
    init(url: String, owner_id: Int, date: Int, size: CGSize) {
        self.url = url
        self.owner_id = owner_id
        self.date = date
        self.size = size
    }
}
