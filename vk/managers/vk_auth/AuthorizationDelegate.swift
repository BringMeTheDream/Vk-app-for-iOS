//
//  AuthorizationDelegate.swift
//  vk
//
//  Created by Андрей Коноплев on 08.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//


protocol AuthorizationDelegate {
    func AuthorizationDidFailed()
    func AuthorizationDidComplete()
}
