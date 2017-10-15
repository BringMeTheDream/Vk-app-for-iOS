//
//  File.swift
//  vk
//
//  Created by Андрей Коноплев on 13.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import SwiftyJSON
import UIKit

class ProfileInfoManager {
    //get account info
    static func getAccountInfoManager(success: @escaping (_ user: User)-> Void, failure: (_ errorDescription: String)-> Void) {
        _ = API_wrapper.getAccountInfo(success: { (response) in
            let profileInfo = JSON(response)
           
            
            
            let first_name = profileInfo["response"]["first_name"].stringValue
            let last_name = profileInfo["response"]["last_name"].stringValue
            let sex = profileInfo["response"]["sex"].intValue
            let screen_name = profileInfo["response"]["screen_name"].stringValue
            let phone_number = profileInfo["response"]["phone"].stringValue

            let user = User(first_name: first_name, last_name: last_name, screen_name: screen_name, sex: sex, phone_number: phone_number)
            
            success(user)
            
        }, failure: { (error) in
            failure(error)
        })
    }
    
    //get Users info
    static func getUsersInfoManager(user: User, success: @escaping (_ user: User)-> Void) {
        _ = API_wrapper.getUserProfileInfo(user: user, success: { (response) in
            let userInfo = JSON(response)
            let infoArray = userInfo["response"].arrayValue

            for info in infoArray {
                let avatarImageUrl = info["photo_50"].stringValue
                let user_id = info["id"].intValue
                user.avatarImage = avatarImageUrl
                user.user_id = user_id
                
            }
           
            success(user)
        }, failure: { (error) in
            print(error)
        })
    }

}
