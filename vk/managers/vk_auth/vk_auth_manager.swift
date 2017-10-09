//
//  File.swift
//  vk
//
//  Created by Андрей Коноплев on 08.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import VK_ios_sdk

class Vk_auth_manager: NSObject {
    static let permissions = ["friends", "photos", "status", "messages", "offline", "groups", "email", "wall"]
    
    
    var delegate: AuthorizationDelegate!
    var vc: UIViewController!
    var sdkInstance: VKSdk!
    
    
    func check_vk_auth(with delegate: AuthorizationDelegate, controller: UIViewController) {
        
        sdkInstance = VKSdk.initialize(withAppId: "6211870")
        VKSdk.instance().register(self)
        VKSdk.instance().uiDelegate = self
        self.delegate = delegate
        self.vc = controller

        VKSdk.wakeUpSession(Vk_auth_manager.permissions) { (state, error) in
            
            if state == .authorized {
                delegate.AuthorizationDidComplete()
                return
            } else {
                
                VKSdk.authorize(Vk_auth_manager.permissions)
            }
        }
    }
}

//MARK: - AUTHORIZATION

extension Vk_auth_manager: VKSdkUIDelegate, VKSdkDelegate {
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        
        DispatchQueue.main.async { [weak self ] in
            self?.vc.present(controller, animated: true)
        }
        
    }
    
    func vkSdkUserAuthorizationFailed() {
        delegate.AuthorizationDidFailed()
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print("CAPTCHA")
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
       
        if let token = result.token {
            UserDefaults.standard.set(token.accessToken, forKey: const.AppDefaultKeys.accessToken)
            UserDefaults.standard.synchronize()
            delegate.AuthorizationDidComplete()
        } else {
             delegate.AuthorizationDidFailed()
        }
    }
}
