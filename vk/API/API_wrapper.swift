//
//  API_wrapper.swift
//  vk
//
//  Created by Андрей Коноплев on 09.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import Foundation

class API_wrapper {
    
    static func getNewsForTape(success: @escaping (_ json: Any)-> Void, failure: @escaping (_ errorDescription: String)-> Void )->URLSessionTask {
        let token = getToken()
        let url = const.requestData.url + "newsfeed.get"
        let params: [String: Any] = [
            "filters": "post%2Cphoto%2Cphoto_tag%2C%20wall_photo",
            "return_banned": 0,
            "count": 30,
            "access_token": token,
            "v": 5.68
        ]
        
        
        let request = API_conf.getRequst(url: url, params: params)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, requestError) in
            API_conf.acceptDataFromServer(data: data, RequestError: requestError, success: success, failure: failure)
        }
        dataTask.resume()
        
        return dataTask
    }
}

extension API_wrapper {
    
    static func getToken()-> String {
        let token1 = UserDefaults.standard.object(forKey: const.AppDefaultKeys.accessToken)
        guard let token = token1 else  {
            return "nn"
        }
        return String(describing: token)
    }
}
