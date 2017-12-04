//
//  File.swift
//  vk
//
//  Created by Андрей Коноплев on 09.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import SwiftyJSON

class API_conf {
    static func getRequst(url: String, params: [String: Any])-> URLRequest {

        var url = url + "?"
        for (key, value) in params {
            url += "\(key)" + "=" + "\(value)" + "&"
        }
        
        url = String(url.dropLast())
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        return request
    }
    
    static func acceptDataFromServer(data: Data?, RequestError: Error?,success: (_ json: Any)-> Void, failure: (_ errorDescription: String)->Void) {
        
        if let error = RequestError {
            switch error._code {
            case NSURLErrorBadURL:
                failure("Плохое подключение")
            case NSURLErrorTimedOut:
                failure("Время вышло")
            case NSURLErrorNotConnectedToInternet:
                failure("Нет подключения к интернету")
            default: failure("что то пошло не так")
            }
        }
        
        guard let data = data else {
            failure("Не удалось полуить данные с сервера")
            return
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            success(json)
        } catch {
            failure("Serialize is fail")
        }
        
    }
}
