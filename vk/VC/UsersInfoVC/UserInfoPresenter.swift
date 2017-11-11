//
//  UserInfoPresenter.swift
//  vk
//
//  Created by Андрей Коноплев on 10.11.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class UserInfoPresenter {
    fileprivate var userService = UserService()
    var controller: UsersInfoVC!
    var user: User?
    var properties = [String]()
    
    func attachController(_ controller: UsersInfoVC!) {
        self.controller = controller
    }
    
    func setUser(user: User) {
        self.user = user
    }
}

extension UserInfoPresenter {
    
    func numOfSection()-> Int {
        return 2
    }
    
    func numCellInRow(section: Int)-> Int {
        if section == 0 {
            return 1
        } else {
            return properties.count
        }
    }
    
    func cellForRowAtIndexPath(tableView: UITableView, section: Int, indexPath: Int)-> UITableViewCell {
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userProfileCell")
            let avatarImage = cell?.contentView.viewWithTag(1) as! UIImageView
            let statusLabel = cell?.contentView.viewWithTag(2) as! UILabel
            avatarImage.kf.setImage(with: URL(string: user?.avatarImage ?? ""))
            statusLabel.text = user?.status
            return cell!
        } else if section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userPropertiesCell")
            let textlabel = cell?.contentView.viewWithTag(1) as! UILabel
            textlabel.text = properties[indexPath]
            return cell!
        }
        return UITableViewCell()
    }
    
    func heightForRow(section: Int)-> CGFloat {
        return section == 0 ? 80 : 40
    }
    
    func titleForSection(section: Int)-> String {
        if section == 0 {
            return "Профиль"
        } 
        return " "
    }
}

extension UserInfoPresenter {
    func setProperties(user: User) {
        var array = [String]()
        array.append(user.getFullName())
        array.append(user.city ?? "")
        array.append(user.phone_number ?? "")
        array.append(user.getSex())
        array.append(user.screen_name)
        array.append(user.bdate ?? "")
        for properties in array {
            if properties != "" {
                self.properties.append(properties)
            }
        }
    }
}
