//
//  UserViewController.swift
//  vk
//
//  Created by Андрей Коноплев on 03.11.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    //MARK:- vars
    var user: User?
    fileprivate var loadingView: LoadingView!
    var userPresenter = UserPresenter()
    var selectedPhoto = 0
    var category = ""
    //MARK:- outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - didLoading
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let unwrappedUser = user else { return }
        userPresenter.setUser(user: unwrappedUser)
        self.navigationItem.title = user?.getFullName()
        tableView.register(UINib(nibName: "HeadCell", bundle: nil), forCellReuseIdentifier: "headCell")
        userPresenter.attachView(self)
        userPresenter.setController(controller: self)
        userPresenter.getUserInfo()
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPresenter.getNumInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return userPresenter.cellForRowAtIndexPath(tableView: tableView, indexPath: indexPath.row)
    }
}

//MARK: UserViewProtocol
extension UserViewController: UserViewProtocol {
    func startLoading() {
        loading()
    }
    func stopLoading() {
        self.loadingView.removeFromSuperview()
        tableView.reloadData()
    }
}

extension UserViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "userPresentationSegue" , let dest = segue.destination as? PhotoGalleryVC {
            dest.selectedPhoto = self.selectedPhoto
            dest.user = self.user
            dest.offset = self.userPresenter.offset
        } else if segue.identifier == "userListSegue", let dest = segue.destination as? ListVC {
            dest.category = self.category
            dest.user = self.user
        } else if segue.identifier == "userVideoSegue", let dest = segue.destination as? VideoListVC {
            dest.user = user
        } else if segue.identifier == "usersInfoSegue", let dest = segue.destination as? UsersInfoVC {
            dest.user = self.user
        }
    }
}
//MARK: - loading
extension UserViewController {
    func loading() {
        self.tableView.register(UINib(nibName: "LoadingView", bundle: nil),forCellReuseIdentifier: "loading")
        self.loadingView = LoadingView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.tableView.addSubview(loadingView)
    }
}
