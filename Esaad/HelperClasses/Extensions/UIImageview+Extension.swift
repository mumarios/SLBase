//
//  UIImageview+Extension.swift
//  Esaad
//
//  Created by Faraz Haider on 10/15/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import Foundation


extension UIImageView {
    
    var imageColor: UIColor? {
        set (newValue) {
            if let image = image {
                if newValue != nil {
                    self.image = image.withRenderingMode(.alwaysTemplate)
                    tintColor = newValue
                } else {
                    self.image = image.withRenderingMode(.alwaysOriginal)
                    tintColor = UIColor.clear
                }
            }
        }
        get {
            return tintColor
        }
    }

}
