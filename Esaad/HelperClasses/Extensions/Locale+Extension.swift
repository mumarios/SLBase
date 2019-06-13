//
//  Locale+Extension.swift
//  Esaad
//
//  Created by Usman on 07/02/2019.
//  Copyright © 2019 Faraz Haider. All rights reserved.
//

import Foundation
import MOLH

public extension Locale{
 
    var myappLocale: Locale {
        get{
            return Locale(identifier: MOLHLanguage.currentLocaleIdentifier())
        }
    }
    
}
