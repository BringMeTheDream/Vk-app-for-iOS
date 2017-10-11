//
//  newsManager.swift
//  vk
//
//  Created by Андрей Коноплев on 10.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import SwiftyJSON

class newsManager {
    static func getNewsForTape(success: @escaping (_ newsInfo: [PostInfo])->Void, failure: @escaping (_ errorDescription: String)->Void) {
        _ = API_wrapper.getNewsForTape(success: { (response) in
            var newsArray = [PostInfo]()
            let jsonResponse = JSON(response)
            let arrayOfItems = jsonResponse["response"]["items"].arrayValue
            
            for item in arrayOfItems {
                let type = item["type"].stringValue
                let like = item["likes"]["count"].intValue
                let reposts = item["reposts"]["count"].intValue
                let dateUpload = item["date"].intValue
                let text = item["text"].stringValue
                let source_id = item["source_id"].intValue
//                let attachments = item["attachments"].arrayValue
                
                let news = PostInfo(type: type, likeCount: like, repostsCount: reposts, dateUpload: dateUpload, source_id: source_id, text: text)
                newsArray.append(news)
            }
//                for attachmentItem in attachments {
//                    attachmentItem[]
//            }
            
           
            success(newsArray)
        }, failure: { (error) in
            failure(error)
        })
    }
}


