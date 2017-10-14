//
//  PostWithImageCell.swift
//  vk
//
//  Created by Андрей Коноплев on 11.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit
import Kingfisher

class PostCell: UITableViewCell {

    @IBOutlet weak var uploadTimeLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var repsotLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

extension PostCell {
    func configure(object: PostInfo) {
        let screenWidth = UIScreen.main.bounds.width
        heightConstraint.constant = getRightHeight(model: object, frame: screenWidth)
        postTextLabel.text = object.text
        newsImage.kf.setImage(with: URL(string: object.attachements?.source_url ?? ""))
        likeLabel.text = String(object.likeCount)
        repsotLabel.text = String(object.repostsCount)
        authorLabel.text = object.author_name
        avatarImage.kf.setImage(with: URL(string: object.author_photo_url ?? ""))
        uploadTimeLabel.text = getTimeUpload(time: object.dateUpload)
        
        
    }
}

extension PostCell {
    func getRightHeight(model: PostInfo,frame: CGFloat)-> CGFloat {
        if model.attachements?.type == "photo" {
            return frame / ((model.attachements?.size?.width ?? 1 )! / (model.attachements?.size?.height ?? 1)!)
        } else {
            return 0
        }
    }
    
    func getTimeUpload(time: Int)-> String {
        let now = Int(NSDate().timeIntervalSince1970)
        var result: String
        let timeUpload = now - time
        if timeUpload < 60 {
            result = "\(timeUpload) секунд назад"
        } else {
            result = "\(timeUpload / 60) минут назад"
        }
        
        return result
    }
}
