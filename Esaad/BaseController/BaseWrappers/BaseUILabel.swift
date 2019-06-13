//
//  BaseUILabel.swift
//  Esaad
//
//  Created by Usman on 07/02/2019.
//  Copyright © 2019 Faraz Haider. All rights reserved.
//

import Foundation
class BaseUILabel: UILabel {
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
            self.textAlignment = .left
              self.contentMode = .left
        }else{
            self.textAlignment = .right
            self.contentMode = .right
        }
    }

    
}

