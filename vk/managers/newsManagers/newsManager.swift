//
//  newsManager.swift
//  vk
//
//  Created by Андрей Коноплев on 10.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import SwiftyJSON

class newsManager {
    static func getNewsForTape(end_time: Int, start_from: Int ,success: @escaping (_ newsInfo: [PostInfo])->Void, failure: @escaping (_ errorDescription: String)->Void) {

        _ = API_wrapper.getNewsForTape(end_time: end_time , start_from: start_from , success: { (response) in
            var newsArray = [PostInfo]()
            let jsonResponse = JSON(response)
            let arrayOfItems = jsonResponse["response"]["items"].arrayValue
            
            
            for item in arrayOfItems {
                let type = item["type"].stringValue
                let like = item["likes"]["count"].intValue
                let reposts = item["reposts"]["count"].intValue
                let dateUpload = item["date"].intValue
                let text = item["text"].stringValue
                let owner_id = item["source_id"].intValue
                let attachments = item["attachments"].arrayValue
                
                let news = PostInfo(type: type, likeCount: like, repostsCount: reposts, dateUpload: dateUpload, owner_id: owner_id, text: text)
                
                
                for attachmentItem in attachments {
                    let type = attachmentItem["type"].stringValue
                    let photo_url = attachmentItem["photo"]["photo_604"].stringValue
                    let width = attachmentItem["photo"]["width"].intValue
                    let height = attachmentItem["photo"]["height"].intValue
                    
                    let attachement = PostAttachments(type: type, source_url: photo_url)
                    attachement.size = CGSize(width: width, height: height)
                    news.attachements = attachement
                }
                
                newsArray.append(news)
            }
            
           
            success(newsArray)
        }, failure: { (error) in
            failure(error)
        })
    }
}

extension newsManager {
    static func getUserInfoForNews(postObject: PostInfo ,success: @escaping ()-> Void) {
        
        _ = API_wrapper.getUserInfo(id: postObject.owner_id, success: { (response) in
            let authorInfo = JSON(response)
           
            
            
            let first_name =  authorInfo["response"]["first_name"].stringValue
            let last_name = authorInfo["response"]["last_name"].stringValue
            let name = "\(first_name) \(last_name)"
            postObject.author_photo_url = authorInfo["response"]["photo_50"].stringValue
            postObject.author_name = name
            print(" имя \(name)")
            
            success()
            
        }, failure: { (error) in
            print(error)
        })
    }
}

extension newsManager {
    static func getGroupInfoForNews(postObject: PostInfo, success: @escaping ()-> Void) {
        let id = postObject.owner_id * (-1)
        _ = API_wrapper.getGroupInfo(id: id, success: { (response) in
            
            let groupInfo = JSON(response)
            let arrayOfGroup = groupInfo["response"].arrayValue
            
            for info in arrayOfGroup {
                postObject.author_name = info["name"].stringValue
                postObject.author_photo_url = info["photo_50"].stringValue
            }
            success()
            
        }, failure: { (error) in
            print(error)
        })
    }
}

