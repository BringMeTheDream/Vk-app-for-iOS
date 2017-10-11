//
//  PostWithImageCell.swift
//  vk
//
//  Created by Андрей Коноплев on 11.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit
import Kingfisher

class PostWithImageCell: UITableViewCell {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var postTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

extension PostWithImageCell {
    func configure() {
        postTextLabel.text = ""
        mainImage.kf.setImage(with: URL(string: "https://pp.userapi.com//c626228//v626228321//2ea35//2Ir-dHN10dk.jpg"))
    }
}
