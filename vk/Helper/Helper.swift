//
//  Helper.swift
//  vk
//
//  Created by Андрей Коноплев on 11.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import Foundation

class Helper {
    static func DivideUsersAndGroups(newsArray: [PostInfo], success: @escaping ()-> Void) {
        let countOfPosts = newsArray.count
        var i = 0
        
        func getInfo() {
            
            if i < countOfPosts && newsArray[i].owner_id > 0 {
                newsManager.getGroupInfoForNews(postObject: newsArray[i]) {
                    if i != countOfPosts - 1 {
                        i = i + 1
                        getInfo()
                    } else {
                        success()
                    }
                }
            } else if i < countOfPosts && newsArray[i].owner_id < 0 {
                newsManager.getGroupInfoForNews(postObject: newsArray[i]){
                    if i != countOfPosts - 1 {
                        i = i + 1
                        getInfo()
                    } else {
                        success()
                    }
                }
                } else {
                    return
                }
        }
        
        getInfo()
 
    }
}
