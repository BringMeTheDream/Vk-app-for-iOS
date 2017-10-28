//
//  VideoCellVC.swift
//  vk
//
//  Created by Андрей Коноплев on 28.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class VideoCellVC: UITableViewCell {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var viewsCount: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension VideoCellVC {
    func configure(model: VideoModel) {
        descriptionLabel.text = model.description
        viewsCount.text = String(model.views)
        durationLabel.text = String(getRightDuration(duration: model.duration))
        pushRequestInWebView(webView: self.webView, link: model.video_url)
        nameLabel.text = model.title
       
    }
}

extension VideoCellVC {
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
    
    func pushRequestInWebView(webView: UIWebView, link: String) {
        let url = URL(string:link)
        let request = NSURLRequest(url: url!)
        webView.loadRequest(request as URLRequest)
        
    }
}
