//
//  HeadCell.swift
//  vk
//
//  Created by Андрей Коноплев on 07.11.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit
import Kingfisher

class HeadCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var last_seenLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    let now = Int(NSDate().timeIntervalSince1970)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }


    func configure(user: User) {
        nameLabel.text = user.getFullName()
        cityLabel.text = user.city
        avatarImage.kf.setImage(with: URL(string:user.avatarImage ?? ""))
        last_seenLabel.text = getLastSeen(time: user.last_seen ?? 0)
        
    }
}


extension HeadCell {
    func getLastSeen(time: Int)-> String {
        
        var result = ""
        let lastSeen = self.now - time
        
        if lastSeen < 300 || time == 0 {
            result = "online"
        } else if lastSeen > 300 && lastSeen < 3600 {
            result = "Был в сети \(lastSeen / 60)  мин назад"
        } else if lastSeen > 3600 && lastSeen < 86400 {
            result = "Был в сети \(lastSeen / 3600) час. назад"
        } else if lastSeen > 86400 {
            result = "Был в сети \(lastSeen / 86400) дн. назад"
        }
        
        return result
    }
}
