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
    
    var photosArray = [PhotoModel]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.black
    }

    
    override func viewWillDisappear(_ animated: Bool) {
      //super.viewWillDisappear(true)
        navigationController?.navigationBar.barTintColor = UIColor(hex: "004080" )
    }
}

extension PhotoGalleryVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath)
        let galleryImage = cell.contentView.viewWithTag(1) as! UIImageView
        galleryImage.kf.setImage(with: URL(string: photosArray[indexPath.row].url))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        navigationItem.title = "\(indexPath.row + 1) из \(photosArray.count)"
    }
}

extension PhotoGalleryVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height = getRightHeight(model: photosArray[indexPath.row], frame: width)
        print(width)
        print(height)
        let size = CGSize(width: width, height: height)
        return size
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension PhotoGalleryVC {
    func getRightHeight(model: PhotoModel, frame: CGFloat)-> CGFloat {
        return frame / ((model.size.width) / (model.size.height))
    }
}
