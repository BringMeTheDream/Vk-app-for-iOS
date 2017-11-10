//
//  UserService.swift
//  vk
//
//  Created by Андрей Коноплев on 07.11.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import SwiftyJSON

class  UserService {
    func getInfo(user: User, success: @escaping (_ user: User) -> Void) {
        _ = API_wrapper.getUserAccountInfo(id: user.user_id! , success: { (response) in
            let responseInfo = JSON(response)
            let array = responseInfo["response"].arrayValue
            
            for info in array {
                user.status = info["status"].stringValue
                user.last_seen = info["last_seen"]["time"].intValue
                user.city = info["city"]["title"].stringValue
                let counters = info["counters"].dictionaryValue
                for description in const.user_info.infoArray {
                     let element = counters[description]?.stringValue
                    if element != nil && element != "0" {
                        user.counters.append(element!)
                        user.openCounters.append(description)
                        }
                }
            }
                
            success(user)
        }, failure: { (error) in
            print(error)
        })
    }
    
    func getVideo(user: User, success: @escaping (_ videoArray: [VideoModel])-> Void) {
        _ = VideoListManager.getVideoListManager(user_id: user.user_id!, success: { (videoArray) in
            success(videoArray)
        })
    }
    
    func getPhotos(user: User, offset: Int, succcess: @escaping ()-> Void) {
        _ = PhotoProfileManager.getProfilePhoto(user: user, offset: offset, success: {
            succcess()
        })
    }
    
    
}
