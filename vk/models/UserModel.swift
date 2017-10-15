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
    let phone_number: String
    
    var avatarImage: String?
    var user_id: Int?
    
    init(first_name: String, last_name: String, screen_name: String, sex: Int, phone_number: String) {
        self.first_name = first_name
        self.last_name = last_name
        self.screen_name = screen_name
        self.sex = sex
        self.phone_number = phone_number
    }
    
    func getFullName()-> String {
        return first_name + " " + last_name
    }
}
