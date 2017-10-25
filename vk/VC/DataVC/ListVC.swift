//
//  FriendsVC.swift
//  vk
//
//  Created by Андрей Коноплев on 19.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class ListVC: UIViewController {
    
    var user: User?
    var category: String?
    var usersArray = [User]()
    var usersOnlineArray = [User]()
    var groupsArray = [Group]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    @IBAction func changeValueOfSegment(_ sender: Any) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = category
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        guard let unwrapUser = user else { return }
        guard let user_id = unwrapUser.user_id else { return }
        sendRequestUser(id: String(user_id))
    }

}

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if category == "groups" {
          return groupsArray.count
        } else {
            switch segmentController.selectedSegmentIndex {
            case 0: return usersArray.count
            case 1: return usersOnlineArray.count
                default: return 0
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! ListCell
        if category == "groups" {
            cell.configureGroup(group: groupsArray[indexPath.row])
        } else {
            
            switch segmentController.selectedSegmentIndex {
            case 0 : cell.configureUser(user: usersArray[indexPath.row])
            case 1 : cell.configureUser(user: usersOnlineArray[indexPath.row])
            default: return UITableViewCell()
            }
        }
        return cell
    }
    
}

extension ListVC {
    fileprivate func sendRequestUser(id: String) {
        UsersAndGroupsManager.getFriends(id: id, category: category!, success: { [weak self] (friendsArray) in
    
            DispatchQueue.main.async {
                self?.usersArray.append(contentsOf: friendsArray)
                self?.usersOnlineArray = (self?.getOnlineUser())!
                print(self?.usersArray.count)
                self?.configureSegment()
                self?.tableView.reloadData()
            }
            
        }) { (error) in
            print(error)
        }
    }
}

extension ListVC {
    
    func getOnlineUser() -> [User] {
        var onlineArray = [User]()
        for user in self.usersArray {
            if user.online == 1 {
                onlineArray.append(user)
            }
        }
        
        return onlineArray
    }
    
    func configureSegment() {
        segmentController.setTitle("\(usersArray.count) friends", forSegmentAt: 0)
        segmentController.setTitle("\(usersOnlineArray.count) online", forSegmentAt: 1)
    }
    
    
}
