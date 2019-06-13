//
//  UITextField+Extension.swift
//  Template
//
//  Created by Axact on 24/02/2017.
//  Copyright © 2017 Muzamil Hassan. All rights reserved.
//

import UIKit
import MOLH

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? Utility.getLocalizedString(self.placeholder!) : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
    
    open override func awakeFromNib() {
        if MOLHLanguage.currentAppleLanguage() == "en" {
            self.textAlignment = .left
        }else{
            self.textAlignment = .right
        }
        
    }
    
    func setRightViewIcon(icon: String) {
        let size : CGFloat = 12.0
        var width : CGFloat = size
        if icon == "tick_icon"{
            width = 16.0
        }
        
        let btnView = UIImageView(frame: CGRect(x: self.frame.size.width - size, y: 0.0, width: width, height: size))
        btnView.image = UIImage(named: icon)
        //btnView.imageEdgeInsets = UIEdgeInsetsMake(0, -(size - 5.0/2.0), 0, 0)
        self.rightViewMode = .always
        self.rightView = btnView
    }

}
