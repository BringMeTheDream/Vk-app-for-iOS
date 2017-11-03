//
//  VideoVC.swift
//  vk
//
//  Created by Андрей Коноплев on 28.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class VideoVC: UIViewController {
    
    var user: User?
    var video: VideoModel?
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        self.navigationItem.title = "Видеозапись"
       tableView.register(UINib(nibName: "VideoCellVC", bundle: nil), forCellReuseIdentifier: "videoCell")
    }

}

extension VideoVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "headVideoCell", for: indexPath)
            let avatarImage = cell.contentView.viewWithTag(1) as! UIImageView
            let nameLabel = cell.contentView.viewWithTag(2) as! UILabel
            let dateLabel = cell.contentView.viewWithTag(3) as! UILabel
            avatarImage.kf.setImage(with: URL(string: user?.avatarImage ?? "" ))
            nameLabel.text = user?.getFullName()
            dateLabel.text = getTimeUploaded(date: video?.date)
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as! VideoCellVC
            
            cell.configure(model: video!)
            return cell
        }
       return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 55
        } else {
            return UITableViewAutomaticDimension
        }
    }
}

extension VideoVC {
    func getTimeUploaded(date: Int?) -> String {
        guard let unwrapedDate = date else { return " " }
        let time = NSDate(timeIntervalSince1970: (TimeInterval(unwrapedDate)))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: time as Date)
        
        return "\(dateString) г."
    }
}
