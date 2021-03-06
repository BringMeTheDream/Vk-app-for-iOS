//
//  NewsVC.swift
//  vk
//
//  Created by Андрей Коноплев on 09.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class NewsVC: UIViewController {
    
    //MARK: - vars
    var newsArray = [PostInfo]()
    var currentTime: Int = Int(NSDate().timeIntervalSince1970)
    var start_from = 0
    var loadingView: LoadingView!
    
    

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
        loading()
        //sendRequest()
        sendRequest1()
    }
}

extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
        cell.configure(object: newsArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == newsArray.count - 2 {
            sendRequest1()
        }
    }
}

extension NewsVC {
    // replaced on operation
//    fileprivate func sendRequest() {
//        newsManager.getNewsForTape(end_time: currentTime, start_from: start_from, success: { [weak self] (objectsArray) in
//            Helper.DivideUsersAndGroups(newsArray: objectsArray, success: {
//
//                self?.start_from +=  const.requestData.countNews
//                DispatchQueue.main.async {
//                    self?.newsArray.append(contentsOf:objectsArray)
//                    self?.tableView.reloadData()
//                    self?.loadingView.removeFromSuperview()
//                }
//            })
//        }) { (error) in
//            print(error)
//        }
//    }
    
    fileprivate func sendRequest1() {
        DataProvider.getNews(end_time: currentTime, start_from: start_from, success: { (objectArray) in
            Helper.DivideUsersAndGroups(newsArray: objectArray, success: {
                self.start_from +=  const.requestData.countNews
                DispatchQueue.main.async {
                    self.newsArray.append(contentsOf:objectArray)
                    self.tableView.reloadData()
                    self.loadingView.removeFromSuperview()
                }
            })
        }) { (error) in
            print(error)
        }
    }
}

extension NewsVC {
    func loading() {
        self.tableView.register(UINib(nibName: "LoadingView", bundle: nil),forCellReuseIdentifier: "loading")
        self.loadingView = LoadingView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.tableView.addSubview(loadingView)
    }
}
