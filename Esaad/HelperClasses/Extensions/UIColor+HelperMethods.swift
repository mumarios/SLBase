//
//  UIColor+HelperMethods.swift
//  Esaad
//
//  Created by Faran Rasheed on 12/04/2019.
//  Copyright © 2019 Systems Ltd. All rights reserved.
//

import Foundation

extension UIColor {
    func brightened(by factor: CGFloat) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return UIColor(hue: h, saturation: s, brightness: b * factor, alpha: a)
    }
}

