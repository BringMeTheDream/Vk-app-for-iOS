//
//  API_wrapper.swift
//  vk
//
//  Created by Андрей Коноплев on 09.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import Foundation

class API_wrapper {
    
    static func getNewsForTape(end_time: Int, start_from: Int,  success: @escaping (_ json: Any)-> Void, failure: @escaping (_ errorDescription: String)-> Void )->URLSessionTask {
        let token = getToken()
        let url = const.requestData.url + "newsfeed.get"
        let params: [String: Any] = [
            "filters": "post%2Cphoto%2Cphoto_tag",
            "return_banned": 0,
            "end_time" : end_time ,
            "start_from": start_from,
            "count": const.requestData.countNews,
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
    //MARK:- get info about user
    static func getUserInfo(id: Int, success: @escaping (_ json: Any)->Void, failure: (_ errorDescription: String)-> Void)->URLSessionTask {
        
        let url = const.requestData.url + "users.get"
        let params: [String: Any] = [
            "user_id": id,
            "fields": "photo_50",
            "v": 5.68
        ]
        
        let request = API_conf.getRequst(url: url, params: params)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, requestError) in
            API_conf.acceptDataFromServer(data: data, RequestError: requestError, success: success, failure: success)
            
        }
        dataTask.resume()
        return dataTask
    }
    
    //MARK:- get info about group
    static func getGroupInfo(id: Int, success: @escaping (_ json: Any)->Void, failure: (_ errorDescription: String)-> Void)->URLSessionTask {
        
        let url = const.requestData.url + "groups.getById"
        let params: [String: Any] = [
            "group_id": id,
            "v": 5.68
        ]
        
        let request = API_conf.getRequst(url: url, params: params)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, requestError) in
            API_conf.acceptDataFromServer(data: data, RequestError: requestError, success: success, failure: success)
            
        }
        dataTask.resume()
        return dataTask
    
    
    }
}
    //MARK: - get info about Profile
extension API_wrapper  {
    
    static func getAccountInfo(success: @escaping (_ json: Any)->Void, failure: (_ errorDescription: String)-> Void)->URLSessionTask {
        
        let url = const.requestData.url + "account.getProfileInfo"
        let params: [String: Any] = [
            "access_token": getToken(),
            "v": 5.68
        ]
        
        let request = API_conf.getRequst(url: url, params: params)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, requestError) in
            API_conf.acceptDataFromServer(data: data, RequestError: requestError, success: success, failure: success)
            
        }
        dataTask.resume()
        return dataTask
    }
}
    //MARK: - get info about users profile

extension API_wrapper  {
    
    static func getUserProfileInfo(user: User, success: @escaping (_ json: Any)->Void, failure: (_ errorDescription: String)-> Void)->URLSessionTask {
        
        let url = const.requestData.url + "users.get"
        let params: [String: Any] = [
            "user_ids": user.screen_name,
            "fields": "photo_50",
            "v": 5.68
        ]
        
        let request = API_conf.getRequst(url: url, params: params)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, requestError) in
            API_conf.acceptDataFromServer(data: data, RequestError: requestError, success: success, failure: success)
            
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
