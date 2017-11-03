//
//  VideoListVC.swift
//  vk
//
//  Created by Андрей Коноплев on 27.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class VideoListVC: UIViewController {
    
    var user: User?
    var videoArray = [VideoModel]()
    var loadingView: LoadingView!
    var filteredVideo = [VideoModel]()
    var isFiltered = false
    var selectedVideo: VideoModel?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loading()
        tableView.register(UINib(nibName: "VideoListCellVC", bundle: nil), forCellReuseIdentifier: "videoCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        self.navigationItem.title = "videos"
        
        VideoListManager.getVideoListManager(user_id: 18297887) { [weak self] (videosArray) in
            
            DispatchQueue.main.async {
                self?.videoArray.append(contentsOf: videosArray)
                self?.tableView.reloadData()
                self?.loadingView.removeFromSuperview()
            }
            
        }
    }
}

extension VideoListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered == false {
            return videoArray.count
        } else {
            return filteredVideo.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as! VideoListCellVC
        if isFiltered == false {
            cell.configure(videoModel: videoArray[indexPath.row])
        } else {
            cell.configure(videoModel: filteredVideo[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if isFiltered == false {
            selectedVideo = videoArray[indexPath.row]
        } else {
            selectedVideo = filteredVideo[indexPath.row]
        }
        performSegue(withIdentifier: "videoSegue", sender: self)
    }
}

extension VideoListVC : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredVideo = videoArray.filter({
            (model: VideoModel) -> Bool in
            return (model.title.lowercased().range(of: searchBar.text!.lowercased()) != nil)
        })
        
        if searchBar.text == "" {
            isFiltered = false
            tableView.reloadData()
        } else {
            isFiltered = true
            tableView.reloadData()
        }
    }
}

extension VideoListVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "videoSegue", let dest = segue.destination as? VideoVC else { return }
        dest.user = user
        dest.video = selectedVideo
    }
    
    func loading() {
        self.tableView.register(UINib(nibName: "LoadingView", bundle: nil),forCellReuseIdentifier: "loading")
        self.loadingView = LoadingView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.tableView.addSubview(loadingView)
    }
}
