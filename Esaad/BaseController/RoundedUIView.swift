//
//  RoundedUIView.swift
//  Esaad
//
//  Created by Usman on 16/01/2019.
//  Copyright © 2019 Faraz Haider. All rights reserved.
//

import Foundation


@IBDesignable
class RoundUIView: UIView {
    
    @IBInspectable var border_color: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = border_color.cgColor
        }
    }
    
    @IBInspectable var border_width: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = border_width
        }
    }
    
    @IBInspectable var corner_radius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = corner_radius
        }
    }
    
}
