//
//  UserCounterCell.swift
//  vk
//
//  Created by Андрей Коноплев on 08.11.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class UserCounterCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    var view: UserViewController!
    var category = ""
    var user: User?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionViewHeightConstraint.constant = 50
    }
    
    func configure(user: User?, view: UserViewController?, category: String ) {
        self.view = view
        self.user = user
        self.category = category
        self.collectionView.reloadData()
    }
    
}

extension UserCounterCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user?.openCounters.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCounterCell", for: indexPath)
        let numLabel = cell.contentView.viewWithTag(1) as! UILabel
        let textLabel = cell.contentView.viewWithTag(2) as! UILabel
        
        numLabel.text =  user?.counters[indexPath.row]
        textLabel.text = user?.openCounters[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cat = user?.openCounters[indexPath.row] else { return }
        self.category = cat
        
        if cat == "photos" {
            view.selectedPhoto = 0
            view.performSegue(withIdentifier: "userPresentationSegue", sender: self)
        } else if cat == "friends" || cat == "followers" || cat == "groups" {
            view.category = self.category
            view.performSegue(withIdentifier: "userListSegue", sender: self)
        } else if cat == "videos" {
            view.category = self.category
            view.performSegue(withIdentifier: "userVideoSegue", sender: self)
        }
    }
}

extension UserCounterCell: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
    }
}
