//
//  ProfileModel.swift
//  vk
//
//  Created by Андрей Коноплев on 11.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import Foundation

class User {
    
    let first_name: String
    let last_name: String
    let screen_name: String
    let sex: Int
   
    var phone_number: String?
    var avatarImage: String?
    var user_id: Int?
    var online: Int?
    var counters = [String]()
    var photos = [PhotoModel]()
    
    init(first_name: String, last_name: String, screen_name: String, sex: Int) {
        self.first_name = first_name
        self.last_name = last_name
        self.screen_name = screen_name
        self.sex = sex
        
    }
    
    func getFullName()-> String {
        return first_name + " " + last_name
    }
}
