//
//  CircularImageView.swift
//  Esaad
//
//  Created by Faraz Haider on 30/10/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import Foundation

@IBDesignable class CircularImageView: UIImageView {
    
    override var image: UIImage? {
        didSet {
            super.image = image?.circularImage(size: nil)
        }
    }
    
}
