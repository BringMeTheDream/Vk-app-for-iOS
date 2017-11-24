//
//  PhotoAlbomVC.swift
//  vk
//
//  Created by Андрей Коноплев on 24.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoGalleryVC: UIViewController {
    
    var user: User?
    var selectedPhoto = 0
    var photosCount = 0
    var offset = 0
    let userService = UserService()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.black
        view.layoutIfNeeded()
        self.collectionView.scrollToItem(at:IndexPath(item: selectedPhoto, section: 0), at: .right, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.barTintColor = UIColor(hex: "004080" )
    }
}

extension PhotoGalleryVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath)
        let galleryImage = cell.contentView.viewWithTag(1) as! UIImageView
        galleryImage.kf.setImage(with: URL(string: user?.photos[indexPath.row].url_604 ?? ""))
        galleryImage.constraints.forEach { (constraint) in
            switch constraint.identifier ?? "" {
            case "width": constraint.constant = UIScreen.main.bounds.width
            case "height": constraint.constant = getRightHeight(model: (user?.photos[indexPath.row])!, frame: CGFloat(UIScreen.main.bounds.width))
            default: break
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        navigationItem.title = "\(indexPath.row + 1) из \(user?.counters[Helper.getCountForIdentifier(user: self.user!, identifier: "photos")] ?? "0")"
        
        if indexPath.row == offset - 5 {
            self.userService.getPhotos(user: self.user!, offset: self.offset, succcess: {
                DispatchQueue.main.async {
                    self.offset += 50
                    self.collectionView.reloadData()
                }
            })
        }
    }
}

extension PhotoGalleryVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        let size = CGSize(width: width, height: height)
        return size
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension PhotoGalleryVC {
    func getRightHeight(model: PhotoModel, frame: CGFloat)-> CGFloat {
        if model.size.width != 0 && model.size.height != 0 {
            return frame / ((model.size.width) / (model.size.height))
        } else {
            return 450
        }
        
    }
}
