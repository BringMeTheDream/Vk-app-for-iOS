//
//  LoadingView.swift
//  vk
//
//  Created by Андрей Коноплев on 03.11.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    

    @IBOutlet var loadingView: UIView!
    @IBOutlet weak var loadingIdentifire: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)
        addSubview(loadingView)
        loadingIdentifire.startAnimating()
        loadingView.frame = self.bounds
        loadingView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
