//
//  UIFont+Extension.swift
//  Mahalati
//
//  Created by Axact on 16/03/2017.
//  Copyright © 2017 Muzamil Hassan. All rights reserved.
//

import UIKit
import Foundation

extension UIFont {    
    func sizeOfString(text: NSString, constrainedToWidth width: Double) -> CGSize {
        return text.boundingRect(with: CGSize(width: width, height: DBL_MAX),
                                 options: .usesLineFragmentOrigin,
                                 attributes: [NSAttributedStringKey.font: self],
                                 context: nil).size
    }
}
