//
//  UserPhotoCell.swift
//  vk
//
//  Created by Андрей Коноплев on 08.11.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit
import Kingfisher

class UserPhotoCell: UITableViewCell {


    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cvHeightConstraint: NSLayoutConstraint!
    
    var view: UserViewController!
    var user: User?
    let userService = UserService()

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configure(user: User?,view: UserViewController?) {
        self.view = view
        self.user = user
        cvHeightConstraint.constant = 75
        collectionView.reloadData()
    }


}

extension UserPhotoCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userPhotorCell", for: indexPath)
        let photoImageView = cell.contentView.viewWithTag(1) as! UIImageView
        photoImageView.kf.setImage(with: URL(string: user?.photos[indexPath.row].url ?? ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.selectedPhoto = indexPath.row
        self.view.performSegue(withIdentifier: "userPresentationSegue", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.view.userPresenter.offset - 5 {
            self.userService.getPhotos(user: self.user!, offset: self.view.userPresenter.offset, succcess: {
                DispatchQueue.main.async {
                    self.view.userPresenter.offset += 50
                    self.collectionView.reloadData()
                }
            })
        }
    }

    
    
}

extension UserPhotoCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: Double = 70
        let width =  getRightWidth(height: Int(height), photo: user?.photos[indexPath.row].size ?? CGSize(width: 0, height: 0))
        return CGSize(width: width, height: height )
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
    }
}

extension UserPhotoCell {
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
