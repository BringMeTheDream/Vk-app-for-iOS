//
//  VideoListCellVC.swift
//  vk
//
//  Created by Андрей Коноплев on 27.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit
import Kingfisher

class VideoListCellVC: UITableViewCell {

    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
  
}

extension VideoListCellVC {
    func configure(videoModel: VideoModel) {
        self.title.text = videoModel.title
        self.duration.text = getRightDuration(duration: videoModel.duration)
        self.videoImage.kf.setImage(with: URL(string: videoModel.photo_url))
    }
}


extension VideoListCellVC {
    func getRightDuration(duration: Int)-> String {
        var minutes = ""
        var seconds = ""
        
        if duration <= 9 {
            minutes = "00"
            seconds = "0\(duration)"
        } else if duration > 9 && duration < 60 {
            minutes = "00"
            seconds = "\(duration)"
        } else {
            minutes = "\(duration / 60)"
            seconds = "\(duration - (Int(minutes)! * 60))"
            
            if Int(seconds)! < 10 {
                seconds = "0\(seconds)"
            }
        }
        return "\(minutes):\(seconds)"
    }
}
