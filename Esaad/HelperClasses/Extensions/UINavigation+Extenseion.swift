//
//  UINavigation+Extenseion.swift
//  Esaad
//
//  Created by Usman on 16/01/2019.
//  Copyright © 2019 Faraz Haider. All rights reserved.
//

import Foundation

extension UINavigationBar {
    
    func transparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
    
    func nonTransparentNavigationBar() {
         self.shadowImage = nil
    }
} 
