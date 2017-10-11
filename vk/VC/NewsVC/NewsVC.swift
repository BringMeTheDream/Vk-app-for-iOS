//
//  NewsVC.swift
//  vk
//
//  Created by Андрей Коноплев on 09.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class NewsVC: UIViewController {

    //MARK: - outlets
    @IBOutlet weak var tableView: UITableView!
    
}

extension NewsVC {
    //MARK: - load
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "postCell")
        tableView.register(UINib(nibName: "PostWithImageCell", bundle: nil), forCellReuseIdentifier: "postWithImageCell")
        
    }
}

extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "postWithImageCell", for: indexPath) as! PostWithImageCell
        cell.configure()
        return cell
    }
}
