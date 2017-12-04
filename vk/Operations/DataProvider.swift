//
//  DataProvider.swift
//  vk
//
//  Created by Андрей Коноплев on 27.11.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import Foundation

class DataProvider {
    static func getNews(end_time: Int, start_from: Int, success: @escaping (_ news: [PostInfo])-> Void, failure: @escaping (_ errorDescription: String)-> Void) {
        let newsOperation = NewsOperation(end_time: end_time, start_from: start_from, success: success, failure: failure)
        OperationManager.addOperation(operation: newsOperation, cancelQueue: true)
    }
}
