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

    //MARK:- get info about user
extension API_wrapper {
    static func getUserInfo(id: Int, success: @escaping (_ json: Any)->Void, failure: @escaping (_ errorDescription: String)-> Void)->URLSessionTask {
        
        let url = const.requestData.url + "users.get"
        let params: [String: Any] = [
            "user_id": id,
            "fields": "photo_50",
            "v": 5.68
        ]
        
        let request = API_conf.getRequst(url: url, params: params)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, requestError) in
            API_conf.acceptDataFromServer(data: data, RequestError: requestError, success: success, failure: failure)
            
        }
        dataTask.resume()
        return dataTask
    }
    
    //MARK:- get info about group
    static func getGroupInfo(id: Int, success: @escaping (_ json: Any)->Void, failure: @escaping (_ errorDescription: String)-> Void)->URLSessionTask {
        
        let url = const.requestData.url + "groups.getById"
        let params: [String: Any] = [
            "group_id": id,
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
    //MARK: - get info about Profile
extension API_wrapper  {
    
    static func getAccountInfo(success: @escaping (_ json: Any)->Void, failure: @escaping (_ errorDescription: String)-> Void)->URLSessionTask {
        
        let url = const.requestData.url + "account.getProfileInfo"
        let params: [String: Any] = [
            "access_token": getToken(),
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
    //MARK: - get info about users profile

extension API_wrapper  {
    
    static func getUserProfileInfo(user: User, success: @escaping (_ json: Any)->Void, failure: @escaping (_ errorDescription: String)-> Void)->URLSessionTask {
        
        let url = const.requestData.url + "users.get"
        let params: [String: Any] = [
            "user_ids": user.screen_name,
            "fields": "counters%2Cphoto_50%2Ccontacts%2Cstatus%2Cbdate",
            "access_token": getToken(),
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

//MARK: - set status
extension API_wrapper {
    static func setStatus(status: String)-> URLSessionTask {
        
        let url = const.requestData.url + "status.set"
        let params: [String: Any] = [
            "text": status,
            "access_token": getToken(),
            "v": 5.68
        ]
        
        let request = API_conf.getRequst(url: url, params: params)
        let dataTask = URLSession.shared.dataTask(with: request) 
        dataTask.resume()
        return dataTask
    }
}

//MARK: get users and groups info
extension API_wrapper {
    //users
    static func getFriendsList(id: String, method: String, success: @escaping (_ json: Any)-> Void, failure: @escaping (_ errorDescription: String)-> Void)-> URLSessionTask {
        
        let url = const.requestData.url + method
        let params: [String: Any] = [
            "user_id": id,
            "fields": "photo_50%2Ccity%2C%20online%2Csex",
            "count" : 1000,
            "name_case": "Nom",
            "v": 5.68
        ]

        let request = API_conf.getRequst(url: url, params: params)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, requestError) in
            API_conf.acceptDataFromServer(data: data, RequestError: requestError, success: success, failure: failure)
            
        }
        dataTask.resume()
        return dataTask
    }
    
    //groups
    static func getGroupsList(user_id: String, success: @escaping (_ json: Any)-> Void, failure: @escaping (_ errorDescription: String)-> Void)-> URLSessionTask {
        
        let url = const.requestData.url + "groups.get"
        let params: [String: Any] = [
            "user_id": user_id,
            "extended": 1,
            "count" : 1000,
            "access_token": getToken(),
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
    static func getVideoList(user_id: Int, success: @escaping (_ json: Any)-> Void, failure: @escaping (_ errorDescription: String)-> Void)-> URLSessionTask {
        
        let url = const.requestData.url + "video.get"
        let params: [String: Any] = [
            "owner_id": user_id,
            "extended": 1,
            "access_token": getToken(),
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

//MARK: - get Photo from profil
extension API_wrapper {
    static func getProfilePhoto(id: Int,offset: Int, success: @escaping (_ json: Any)-> Void)-> URLSessionTask {
        let url = const.requestData.url + "photos.getAll"
        let params: [String: Any] = [
            "owner_id": id,
            "album_id": "wall",
            "count": 50,
            "offset" : offset,
            "rev": 0,
            "extended": 0,
            "photo_sizes": 0,
            "access_token": getToken(),
            "v": 5.69
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
    static func getUserAccountInfo(id:Int, success: @escaping (_ json: Any)-> Void, failure: (_ error: String)-> Void)->URLSessionTask {
        let url = const.requestData.url + "users.get"
        let params: [String: Any] = [
            "user_ids": id,
            "fields": "photo_50%2C%20city%2C%20status%2C%20last_seen%2C%20has_mobile%2Csex%2Ccounters&params",
            "name_case": "Nom",
            "access_token": getToken(),
            "v": 5.69
        ]
        print(getToken())
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
