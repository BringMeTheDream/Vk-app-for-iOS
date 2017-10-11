//
//  FeedVC.swift
//  vk
//
//  Created by Андрей Коноплев on 08.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit


class FeedVC: UIViewController {
    
    var authorizeManager = Vk_auth_manager()
    

}

//MARK: - load view
extension FeedVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorizeManager.check_vk_auth(with: self, controller: self)
        newsManager.getNewsForTape(success: { (asd) in
            print("Удача")
        }) { (error) in
            print(error)
        }
    }
}


extension FeedVC: AuthorizationDelegate {
    func AuthorizationDidFailed() {
        print("fail")
    }
    
    func AuthorizationDidComplete() {
        print("complete")
    }

}
