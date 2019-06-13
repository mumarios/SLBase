//
//  UIViewController+Extension.swift
//  Template
//
//  Created by Faraz Haider on 05/01/2017.
//  Copyright © 2017 Muzamil Hassan. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID : String {
        
        //if your storyboard name is same as ControllerName uncomment it
        //return "\(self)"
        return "\(self)" + "_ID"
        
    }
    
    class func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    class func fromNib<T: UIView>() -> T {
            return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

