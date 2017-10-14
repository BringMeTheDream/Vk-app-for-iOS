//
//  TableViewCell.swift
//  vk
//
//  Created by Андрей Коноплев on 13.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import Kingfisher

class HeaderCell: UITableViewCell {

    @IBOutlet weak var avatarimage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(user: User) {
            fullNameLabel.text = user.getFullName()
            avatarimage.kf.setImage(with: URL(string: user.avatarImage ?? ""))
    }
    
}
