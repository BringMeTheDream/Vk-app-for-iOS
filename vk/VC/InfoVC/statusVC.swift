//
//  statusVC.swift
//  vk
//
//  Created by Андрей Коноплев on 15.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class statusVC: UIViewController {

    @IBOutlet weak var textField: UITextField!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }

    @IBAction func changeStatus(_ sender: Any) {
        guard let status = textField.text else {
            return
        }
        _ = API_wrapper.setStatus(status: status)
        self.user?.status = status
        self.navigationController?.popViewController(animated: true)
    }
}

extension statusVC: UITextFieldDelegate {
    
}
