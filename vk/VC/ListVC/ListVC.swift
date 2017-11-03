//
//  FriendsVC.swift
//  vk
//
//  Created by Андрей Коноплев on 19.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class ListVC: UIViewController {
    
    //MARK: - vars
    var user: User?
    var category: String?
    var loadingView: LoadingView!
    var usersArray = [User]()
    var usersOnlineArray = [User]()
    var groupsArray = [Group]()
    var filteredUser = [User]()
    var filteredOnlineUser = [User]()
    var filteredGroups = [Group]()
    var isSearching = false
    
    

    //MARK: - outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var bottomView: UIView!

    
    //MARK: - didLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        loading()
        self.navigationItem.title = category
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        guard let unwrapUser = user else { return }
        guard let user_id = unwrapUser.user_id else { return }
        sendRequestUser(id: String(user_id))
        
    }
}

//MARK: - table view delegate and dataSource
extension ListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if category == "groups" {
            bottomView.isHidden = true
            if isSearching == false {
                return groupsArray.count
            } else {
                return filteredGroups.count
            }
        } else {
            if isSearching == false {
                switch segmentController.selectedSegmentIndex {
                case 0: return usersArray.count
                case 1: return usersOnlineArray.count
                default: return 0
                }
            } else {
                switch segmentController.selectedSegmentIndex {
                case 0: return filteredUser.count
                case 1: return filteredOnlineUser.count
                default: return 0
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! ListCell
        if category == "groups" {
            if isSearching == false {
                cell.configureGroup(group: groupsArray[indexPath.row])
            } else {
                cell.configureGroup(group: filteredGroups[indexPath.row])
            }
            
        } else {
            
            if isSearching == false {
                switch segmentController.selectedSegmentIndex {
                case 0 : cell.configureUser(user: usersArray[indexPath.row])
                case 1 : cell.configureUser(user: usersOnlineArray[indexPath.row])
                default: return UITableViewCell()
                }
            } else {
                switch segmentController.selectedSegmentIndex {
                case 0 : cell.configureUser(user: filteredUser[indexPath.row])
                case 1 : cell.configureUser(user: filteredOnlineUser[indexPath.row])
                default: return UITableViewCell()
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - searchBar delegate
extension ListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredUser = usersArray.filter({
            (model: User) -> Bool in
            return (model.getFullName().lowercased().range(of: searchBar.text!.lowercased()) != nil)
        })
        
        filteredOnlineUser = usersArray.filter({
            (model: User) -> Bool in
            return (model.getFullName().lowercased().range(of: searchBar.text!.lowercased()) != nil)
        })
        
        filteredGroups = groupsArray.filter({
            (model: Group) -> Bool in
            return (model.name.lowercased().range(of: searchBar.text!.lowercased()) != nil)
        })
        
        
        if searchBar.text == "" {
            isSearching = false
            tableView.reloadData()
            
        } else {
            isSearching = true
            tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
//MARK: - sendRequest
extension ListVC {
    fileprivate func sendRequestUser(id: String) {
        UsersAndGroupsManager.getFriends(id: id, category: category!, success: { [weak self] (friendsArray) in
            UsersAndGroupsManager.getGroups(user_id: id, success: { (GroupsArray) in
                DispatchQueue.main.async {
                    self?.usersArray.append(contentsOf: friendsArray)
                    self?.usersOnlineArray = (self?.getOnlineUser())!
                    self?.groupsArray.append(contentsOf: GroupsArray)
                    self?.configureSegment()
                    self?.tableView.reloadData()
                    self?.loadingView.removeFromSuperview()
                }
            })
            
        }) { (error) in
            print(error)
        }
    }
}

//MARK: - other functions
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
    
    func loading() {
        self.tableView.register(UINib(nibName: "LoadingView", bundle: nil),forCellReuseIdentifier: "loading")
        self.loadingView = LoadingView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.tableView.addSubview(loadingView)
    }
    
    @IBAction func changeValueOfSegment(_ sender: Any) {
        tableView.reloadData()
    }
    
}
