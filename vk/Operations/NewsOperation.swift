//
//  NewsOperation.swift
//  vk
//
//  Created by Андрей Коноплев on 27.11.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import SwiftyJSON

class NewsOperation: Operation {
    var success: ([PostInfo]) -> Void
    var failure: (String)-> Void
    var end_time: Int
    var start_from: Int
    
    var urlSessionTask: URLSessionTask?
    
    init(end_time: Int, start_from: Int ,success: @escaping ([PostInfo])-> Void, failure: @escaping (String)-> Void) {
        self.success = success
        self.failure = failure
        self.end_time = end_time
        self.start_from = start_from
    }
    
    override func cancel() {
        urlSessionTask?.cancel()
    }
    
    override func main() {
        let semaphore = DispatchSemaphore(value: 0)
        
        _ = API_wrapper.getNewsForTape(end_time: self.end_time, start_from: start_from, success: { (response) in
            
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
            self.success(newsArray)
            semaphore.signal()
        }) { (error) in
            print(error)
            semaphore.signal()
        }
    }
}
