//
//  UIcolor+hex.swift
//  vk
//
//  Created by Андрей Коноплев on 25.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1) {
        var cleanedHex = hex
        if hex.hasPrefix("#") { cleanedHex = String(hex.characters.dropFirst()) }
        var rgbValue: UInt32 = 0
        Scanner(string: cleanedHex).scanHexInt32(&rgbValue)
        let red     = CGFloat((rgbValue >> 16) & 0xff) / 255
        let green   = CGFloat((rgbValue >> 08) & 0xff) / 255
        let blue    = CGFloat((rgbValue >> 00) & 0xff) / 255
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
