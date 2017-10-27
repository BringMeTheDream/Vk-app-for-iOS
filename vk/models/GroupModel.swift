//
//  GroupModel.swift
//  vk
//
//  Created by Андрей Коноплев on 20.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import Foundation

class Group {
    let name: String
    let id: String
    let avatar: String
    
    init(name: String, id: String, avatar: String) {
        self.name = name
        self.id = id
        self.avatar = avatar
    }
}
