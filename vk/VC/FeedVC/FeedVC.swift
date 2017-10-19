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
    
    var authorizeManager = Vk_auth_manager()
    var user: User?
    
}


//MARK: - load view
extension FeedVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        HeadTableView.estimatedRowHeight = 120
        HeadTableView.rowHeight = UITableViewAutomaticDimension
        authorizeManager.check_vk_auth(with: self, controller: self)
        getRegistrate()
        sendRequest()
    }
}


extension FeedVC: AuthorizationDelegate {
    func AuthorizationDidFailed() {
        print("fail")
    }
    
    func AuthorizationDidComplete() {
        print("complete")
    }
}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
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
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            if let cell = cell as? CounterCell {
                cell.collectionView.dataSource = self
                cell.collectionView.reloadData()
            }
        }
    }
}
//MARK: - collectionView with counters configurate
extension FeedVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let unwrappUser = user else {
         return 0
        }
        return unwrappUser.counters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CounterCell", for: indexPath)
        let numberLabel = cell.contentView.viewWithTag(11) as! UILabel
        let descriptionLabel = cell.contentView.viewWithTag(12) as! UILabel
        numberLabel.text = user?.counters[indexPath.row]
        descriptionLabel.text = const.user_info.infoArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  
        return indexPath.row == 1 ? 60 : UITableViewAutomaticDimension
    }
}

//MARK: - request to API and reload view
extension FeedVC {
    func sendRequest() {
        ProfileInfoManager.getAccountInfoManager(success: { (user) in
            ProfileInfoManager.getUsersInfoManager(user: user, success: { (userWithAvatar) in
                DispatchQueue.main.async {
                    self.user = userWithAvatar
                    self.navigationItem.title = user.first_name
                    self.HeadTableView.reloadData()
                }
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
        
        guard segue.identifier == "infoSegue", let dest = segue.destination as? InfoVC else {
            return
        }
        
        dest.user = user
    }
}
