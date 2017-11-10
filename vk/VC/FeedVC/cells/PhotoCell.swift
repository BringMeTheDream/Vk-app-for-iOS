//
//  photoCell.swift
//  vk
//
//  Created by Андрей Коноплев on 19.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var collectionHeightConstraint: NSLayoutConstraint!
    
    var controller: FeedVC!
    var user: User?
    
}

extension PhotoCell {
    func configure(user: User?, controller: FeedVC) {
        guard let unwrappUser = user else { return }
        self.user = unwrappUser
        self.controller = controller
        self.photoCollectionView.reloadData()

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.photoCollectionView.delegate = self
        self.photoCollectionView.dataSource = self
        self.collectionHeightConstraint.constant = 100
    }
}

extension PhotoCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let unwrappUser = user else { return 0 }
        return unwrappUser.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath)
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        imageView.kf.setImage(with: URL(string: user?.photos[indexPath.row].url ?? ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        controller.selectedGalleryIndex = indexPath.row
        controller.performSegue(withIdentifier: "presentationSegue", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == controller.offset {
            PhotoProfileManager.getProfilePhoto(user: self.user, offset: self.controller.offset, success: {
                DispatchQueue.main.sync {
                    self.controller.offset += 50
                    self.photoCollectionView.reloadData()
                }
            })
        }
    }
}

extension PhotoCell: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: Double = 70
        let width = getRightWidth(height: 70, photo: user?.photos[indexPath.row].size ?? CGSize(width: 0, height: 0))
        let size = CGSize(width: width, height: height)
        return size
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
    
  
}

//MARK: - other function
extension PhotoCell {
    func getRightWidth(height: Int, photo: CGSize) -> Double {
        if photo.width == 0 || photo.height == 0 {
            return Double(height)
        } else {
            let k = Double(height) / Double(photo.height)
            let width = Double(photo.width) * Double(k)
            return width
        }
    }
}
    
    

