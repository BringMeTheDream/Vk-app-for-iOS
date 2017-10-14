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
            print(const.AppDefaultKeys.accessToken)
            
            let first_name = profileInfo["response"]["first_name"].stringValue
            let last_name = profileInfo["response"]["last_name"].stringValue
            let sex = profileInfo["response"]["sex"].intValue
            let screen_name = profileInfo["response"]["screen_name"].stringValue

            let user = User(first_name: first_name, last_name: last_name, screen_name: screen_name, sex: sex)
            
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
                user.avatarImage = avatarImageUrl
            }
           
            success(user)
        }, failure: { (error) in
            print(error)
        })
    }

}
