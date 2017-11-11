//
//  UsersInfoVC.swift
//  vk
//
//  Created by Андрей Коноплев on 10.11.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class UsersInfoVC: UIViewController {

    var userInfoPresenter = UserInfoPresenter()
    var user: User?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let unwrappedUser = user else { return }
        userInfoPresenter.attachController(self)
        userInfoPresenter.setUser(user: unwrappedUser)
        userInfoPresenter.setProperties(user: unwrappedUser)
    }
}

extension UsersInfoVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return userInfoPresenter.numOfSection()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInfoPresenter.numCellInRow(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return userInfoPresenter.cellForRowAtIndexPath(tableView: tableView, section: indexPath.section, indexPath: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return userInfoPresenter.heightForRow(section: indexPath.section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return userInfoPresenter.titleForSection(section: section)
    }
}
