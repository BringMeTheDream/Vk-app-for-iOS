//
//  PostCell.swift
//  vk
//
//  Created by Андрей Коноплев on 11.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    
}

extension PostCell {
    func configure() {
    postText.text = "В Москве сегодня облочно и много дождей и тестеров и програмистов ааа привет всем)"
    }
}
