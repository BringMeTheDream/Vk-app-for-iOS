//
//  customImageView.swift
//  vk
//
//  Created by Андрей Коноплев on 15.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class customImageViewProfile: UIImageView {
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: superview)
        setStyle()
    }
    
    private func setStyle() {
        layer.borderWidth = 1
        layer.cornerRadius = 30
        layer.masksToBounds = true
        
    }
    
}

class customImageViewNews: UIImageView {
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: superview)
        setStyle()
    }
    
    private func setStyle() {
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
    }
}

class customImageViewList: UIImageView {
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: superview)
        setStyle()
    }
    
    private func setStyle() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 25
        layer.masksToBounds = true
        
    }
    
}
