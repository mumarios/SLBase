//
//  BaseUIButton.swift
//  Esaad
//
//  Created by Usman on 18/01/2019.
//  Copyright © 2019 Faraz Haider. All rights reserved.
//

import Foundation

class BaseUIButton : UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        if Singleton.sharedInstance.isEnglishLanguageSelected{
            self.contentHorizontalAlignment = .left
        }else{
            self.contentHorizontalAlignment = .right
        }
    }

}

