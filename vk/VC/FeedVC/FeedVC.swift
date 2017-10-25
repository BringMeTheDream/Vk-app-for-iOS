//
//  FeedVC.swift
//  vk
//
//  Created by Андрей Коноплев on 08.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit


//MARK:- outlets and vars
class FeedVC: UIViewController {
    
    @IBOutlet weak var HeadTableView: UITableView!
    @IBOutlet weak var headerTavbleViewConstraint: NSLayoutConstraint!
    
    var authorizeManager = Vk_auth_manager()
    var user: User?
    var category = ""
}


//MARK: - load view
extension FeedVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        HeadTableView.estimatedRowHeight = 120
        HeadTableView.rowHeight = UITableViewAutomaticDimension
        getRegistrate()
        authorizeManager.check_vk_auth(with: self, controller: self)
    }
}


extension FeedVC: AuthorizationDelegate {
    func AuthorizationDidFailed() {
        print("failed")
    }
    
    func AuthorizationDidComplete() {
        sendRequest()
    }
}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = HeadTableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! HeaderCell
            if let userInCell = user {
                cell.configure(user: userInCell)
                cell.infoButton.addTarget(self, action: #selector(showInfo), for: .touchUpInside)
                 return cell
            }
        } else if indexPath.row == 1 {
            let cell = HeadTableView.dequeueReusableCell(withIdentifier: "cellForCollection", for: indexPath) as! CounterCell
            cell.configure(user: self.user, category: self.category, controller: self)
            return cell
        } else if indexPath.row == 2 {
            let cell = HeadTableView.dequeueReusableCell(withIdentifier: "cellForPhotoCollection", for: indexPath) as! PhotoCell
            cell.configure(user: self.user, controller: self)
            let labelAmountPhotos = cell.contentView.viewWithTag(1) as! UILabel
            labelAmountPhotos.text = String(describing: self.user?.photos.count ?? 0) + " фото"
            
            self.headerTavbleViewConstraint.constant = self.HeadTableView.contentSize.height
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 1 ? 60 : UITableViewAutomaticDimension
    }
    
    
}


//MARK: - request to API and reload view
extension FeedVC {
    func sendRequest() {
        ProfileInfoManager.getAccountInfoManager(success: { (user) in
            ProfileInfoManager.getUsersInfoManager(user: user, success: { (userWithInfo) in
               PhotoProfileManager.getProfilePhoto(user: user, success: { () in
                    DispatchQueue.main.async {
                        self.user = userWithInfo
                        self.navigationItem.title = user.first_name
                        self.HeadTableView.reloadData()
                    }
                })
               
            })
        }) { (error) in
            print(error)
        }
    }
}

//MARK: - other func
extension FeedVC {
    func getRegistrate() {
        HeadTableView.register(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "headerCell")
    }
    
    @objc func showInfo() {
        performSegue(withIdentifier: "infoSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if  segue.identifier == "infoSegue" , let dest = segue.destination as? InfoVC {
            dest.user = user
        } else if segue.identifier == "listSegue" , let dest = segue.destination as? ListVC {
            dest.user = user
            dest.category = category
        } else if segue.identifier == "presentationSegue", let dest = segue.destination as? PhotoGalleryVC {
            dest.photosArray = (user?.photos)!
        }
    }
}

