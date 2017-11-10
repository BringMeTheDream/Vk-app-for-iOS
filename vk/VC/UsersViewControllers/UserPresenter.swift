//
//  UsersPresenter.swift
//  vk
//
//  Created by Андрей Коноплев on 03.11.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import Foundation
import UIKit

protocol UserViewProtocol: NSObjectProtocol {
    func startLoading()
    func stopLoading()
    
}

class UserPresenter {
    fileprivate let userService = UserService()
    weak fileprivate var userView: UserViewProtocol?
    var user: User?
    var category = ""
    var controller: UserViewController!
    var offset = 0
    
    
    func attachView(_ view: UserViewProtocol) {
        self.userView = view
    }
    
    func setUser(user: User?) {
        self.user = user
    }
    
    func setController(controller: UserViewController!) {
        self.controller = controller
    }
}

extension UserPresenter {
    func getUserInfo() {
        self.userView?.startLoading()
        guard let unwrappedUser = self.user else { return }
        
        self.userService.getInfo(user: unwrappedUser) { [weak self] (user) in
            self?.userService.getPhotos(user: user, offset: 0, succcess: {
                DispatchQueue.main.async {
                    self?.user = user
                    self?.userView?.stopLoading()
                    self?.offset += 50
                }
            })
        }
    }
    
    func getUserPhoto() {
        self.userService.getPhotos(user: self.user!, offset: self.offset) { 
            DispatchQueue.main.async {
                self.offset += 50
            }
        }
    }
}

extension UserPresenter {
    func getNumInSection()-> Int {
        return 3
    }
    
    func cellForRowAtIndexPath(tableView: UITableView, indexPath: Int)-> UITableViewCell {
        if indexPath == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "headCell") as! HeadCell
            cell.configure(user: self.user!)
            return cell
        } else if indexPath == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "counterCellCollection") as! UserCounterCell
            cell.configure(user: self.user, view: self.controller, category: self.category)
            return cell
        } else if indexPath == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "photoCellCollection") as! UserPhotoCell
            cell.configure(user: self.user, view: self.controller)
            let countLabel = cell.contentView.viewWithTag(1) as! UILabel
            if user?.counters.count ?? 0 > 3 {
                countLabel.text = "\(user?.counters[3] ?? "0") photos"
            }
            
            return cell
        }
        return UITableViewCell()
    }
}
