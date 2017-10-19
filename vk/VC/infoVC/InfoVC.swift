//
//  InfoVCViewController.swift
//  vk
//
//  Created by Андрей Коноплев on 14.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit
import Kingfisher

class InfoVC: UIViewController {
    
    var user: User?
    var propertiesArray = [String]()
    
    @IBOutlet weak var InfoTableView: UITableView!
    @IBOutlet weak var statusTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InfoTableView.estimatedRowHeight = 120
        InfoTableView.rowHeight = UITableViewAutomaticDimension
        guard let User = user else { return }
        self.navigationItem.title = user?.getFullName()
        setProperties(user: User)
    }
    
    @IBAction func showTextField(_ sender: Any) {
        performSegue(withIdentifier: "statusSegue", sender: self)
    }
}

extension InfoVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            return propertiesArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = InfoTableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath)
            let avatarImage = cell.contentView.viewWithTag(1) as! UIImageView
            avatarImage.kf.setImage(with: URL(string: user?.avatarImage ?? ""))
            return cell
        } else if indexPath.section == 1 {
            let cell = InfoTableView.dequeueReusableCell(withIdentifier: "setStatusCell", for: indexPath)
            return cell
        } else {
            let cell = InfoTableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
            let infoLabel = cell.contentView.viewWithTag(3) as! UILabel
            infoLabel.text = propertiesArray[indexPath.row]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0  ? 80 : 40
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Профиль"
        } else if section == 1 {
            return "Статус:"
        } else {
            return " "
        }
    }
    
    
    
}

extension InfoVC {
    func setProperties(user: User) {
        
        let name = user.getFullName()
        let sex = getSex(sex: user.sex)
        let phone_number = user.phone_number ?? ""
        
        propertiesArray.append(name)
        propertiesArray.append(sex)
        propertiesArray.append(phone_number)
        
    }
    
    func getSex(sex: Int) -> String {
        
        if sex == 2 {
            return "Мужской"
        } else {
            return "Женский"
        }
    }
}
