//
//  PhotoProfileManager.swift
//  vk
//
//  Created by Андрей Коноплев on 23.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import SwiftyJSON

class PhotoProfileManager {
    static func getProfilePhoto(user: User?, success: @escaping ()-> Void) {
        guard let unwrappedUser = user else { return }
        guard let unwrappedId = unwrappedUser.user_id else { return }
        _ = API_wrapper.getProfilePhoto(id: unwrappedId, success: { (response) in
            
            let jsonResponse = JSON(response)
            let arrayResponse = jsonResponse["response"]["items"].arrayValue
            
            for item in arrayResponse {
                let id = item["owner_id"].intValue
                let url = item["photo_75"].stringValue
                let date = item["date"].intValue
                let width = item["width"].intValue
                let height = item["height"].intValue
                let size = CGSize(width: width, height: height)
                
                let photo = PhotoModel(url: url, owner_id: id, date: date, size: size)
                unwrappedUser.photos.append(photo)
            }
            success()
        })
    }
}
