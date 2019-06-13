//
//  UILable+Extension.swift
//  Esaad
//
//  Created by Faraz Haider on 12/5/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
  
    open override func awakeFromNib() {
        if let title = self.text{
            self.text = Utility.getLocalizedString(title)
        }
        
    }

}
