//
//  ListCell.swift
//  vk
//
//  Created by Андрей Коноплев on 20.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit
import Kingfisher

class ListCell: UITableViewCell {


    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var online: UIImageView!
    
    
    func configureUser(user: User) {
        self.avatarImage.kf.setImage(with: URL(string: user.avatarImage ?? ""))
        self.nameLabel.text = user.getFullName()
        
        guard let onlineStatus = user.online else { return }
        if onlineStatus == 1  {
            
            online.image = UIImage(named: "phone")
        } else {
            online.image = nil
        }
    }
    
    func configureGroup(group: Group) {
        self.avatarImage.kf.setImage(with: URL(string: group.avatar))
        self.nameLabel.text = group.name
    }

}
