//
//  UsersAndGroupsManager.swift
//  vk
//
//  Created by Андрей Коноплев on 20.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import SwiftyJSON


class UsersAndGroupsManager {
    //users
    static func getFriends(id: String, category: String, success: @escaping (_ usersArray: [User])-> Void, failure: (_ errorDescription: String)-> Void) {
        var method = ""
        if category == "friends" {
            method = "friends.get"
        } else {
            method = "users.getFollowers"
        }
        _ = API_wrapper.getFriendsList(id: id, method: method, success: { (response) in
            let responseArray = JSON(response)
            let arrayOfUsers = responseArray["response"]["items"].arrayValue
            var usersArray = [User]()
            
            for user in arrayOfUsers {
                let first_name = user["first_name"].stringValue
                let last_name = user["last_name"].stringValue
                let sex = user["sex"].intValue
                let screen_name = ""
                let photo_url = user["photo_50"].stringValue
                let online = user["online"].intValue
    
                let user = User(first_name: first_name, last_name: last_name, screen_name: screen_name, sex: sex)
                user.avatarImage = photo_url
                user.online = online
                usersArray.append(user)
            }
            
            
            success(usersArray)
        } , failure: { (error) in
            failure(error)
        })
    }
    
    //groups
    static func getGroups(user_id: String, success: @escaping (_ groupsArray: [Group])-> Void) {
        _ = API_wrapper.getGroupsList(user_id: user_id, success: { (response) in
            let responseJSON = JSON(response)
            let arrayOfResponse = responseJSON["response"]["items"].arrayValue
            var groupsArray = [Group]()
            
            for item in arrayOfResponse {
                let id = item["id"].stringValue
                let name = item["name"].stringValue
                let avatar_img = item["photo_50"].stringValue
                
                let groupObject = Group(name: name, id: id, avatar: avatar_img)
                groupsArray.append(groupObject)
            }
            
            success(groupsArray)
            
        }, failure: { (error) in
            print(error)
        })
    }
}
