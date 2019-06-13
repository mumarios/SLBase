//
//  CircularButton.swift
//  Esaad
//
//  Created by Faraz Haider on 30/10/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import Foundation

@IBDesignable class CircularImageButton: UIButton {
    
    override func setImage(_ image: UIImage?, for state: UIControlState) {
        let circularImage = image?.circularImage(size: nil)
        super.setImage(circularImage, for: state)
    }
    
}
