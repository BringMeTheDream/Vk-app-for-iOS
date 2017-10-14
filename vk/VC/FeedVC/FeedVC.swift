//
//  FeedVC.swift
//  vk
//
//  Created by Андрей Коноплев on 08.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit


//MARK:- outlets and vars
class FeedVC: UIViewController {
    
    @IBOutlet weak var HeadTableView: UITableView!
    
    
    var authorizeManager = Vk_auth_manager()
    var user: User?
    
}


//MARK: - load view
extension FeedVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        authorizeManager.check_vk_auth(with: self, controller: self)
        getRegistrate()
        sendRequest()
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

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HeadTableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! HeaderCell
        if let userInCell = user {
            cell.configure(user: userInCell)
        }
        
        return cell
    }
    
}

//MARK: - request to API and reload view
extension FeedVC {
    func sendRequest() {
        ProfileInfoManager.getAccountInfoManager(success: { (user) in
            ProfileInfoManager.getUsersInfoManager(user: user, success: { (userWithAvatar) in
                DispatchQueue.main.async {
                    self.user = userWithAvatar
                    self.HeadTableView.reloadData()
                }
            })
        }) { (error) in
            print(error)
        }
    }
}

//MARK: - other func
extension FeedVC {
    func getRegistrate() {
        HeadTableView.register(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "headerCell")
    }
}
