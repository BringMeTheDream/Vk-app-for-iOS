//
//  CounterCell.swift
//  vk
//
//  Created by Андрей Коноплев on 19.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class CounterCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var user: User?
    var category: String = ""
    var controller: FeedVC!
}

extension CounterCell {
    func configure(user: User?, category: String, controller: FeedVC ) {
        guard let unwrappUser = user else {
            return
        }
        self.user = unwrappUser
        self.category = category
        self.controller = controller
        self.collectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension CounterCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return user?.openCounters.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CounterCell", for: indexPath)
        let numberLabel = cell.contentView.viewWithTag(11) as! UILabel
        let descriptionLabel = cell.contentView.viewWithTag(12) as! UILabel
        numberLabel.text = user?.counters[indexPath.row]
        descriptionLabel.text = user?.openCounters[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cat = user?.openCounters[indexPath.row]
        guard let category = cat else { return }
        controller.category = category
        if cat == "friends" || cat == "followers" || cat == "groups" {
            controller.performSegue(withIdentifier: "listSegue", sender: self)
        } else if cat == "videos" {
            controller.performSegue(withIdentifier: "videoListSegue", sender: self)
        } else if cat == "photos" {
            controller.selectedGalleryIndex = 0
            controller.performSegue(withIdentifier: "presentationSegue", sender: self)
        }
    }
}



