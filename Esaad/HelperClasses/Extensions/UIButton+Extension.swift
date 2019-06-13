//
//  UIButton+Extension.swift
//  MediaVoir
//
//  Created by Soomro Shahid on 11/25/16.
//  Copyright © 2016 OutreachGlobal. All rights reserved.
//

import UIKit
import MOLH

extension UIButton {
    
    open override func awakeFromNib() {
        if let title = self.titleLabel?.text{
            self.setTitle(Utility.getLocalizedString(title), for: UIControlState.normal)
        }
        
        if let image = self.image(for: UIControlState.normal) {
            self.setImage(image.flipIfNeeded(), for: .normal)
        }
    }
}





class LocalizeButtonsAlignment: UIButton {
    
    var id : Int = 0
    
    @IBInspectable public var onLocalizeAlignment: Bool = false {
        willSet(onLocalizeAlignment) {
            if onLocalizeAlignment {
                if MOLHLanguage.currentAppleLanguage() == "en" {
                    self.contentHorizontalAlignment = .left
                }else{
                    self.contentHorizontalAlignment = .right
                }
            } else {
                self.contentHorizontalAlignment = .center
            }
        }
    }
    
//    @IBInspectable public var flipRequired: Bool = false {
//        willSet(flipRequired) {
//            if let image = self.image(for: UIControlState.normal) {
//                if flipRequired {
//                    self.setImage(image.flipIfNeeded(), for: .normal)
//                } else {
//                    self.setImage(image, for: .normal)
//                }
//            }
//        }
//    }
    
}


