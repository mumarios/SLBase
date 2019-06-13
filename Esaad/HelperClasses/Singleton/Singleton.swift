//
//  Singleton.swift
//  Versole
//
//  Created by Soomro Shahid on 5/13/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import Foundation
class Singleton : NSObject{

    static let sharedInstance = Singleton()
    override init() {}
    
    
    var objItem:NSMutableDictionary!
    var isOrderProgress:Bool = false
    var deviceToken:String = ""
    var deviceId:String = ""
    var selectedDate: [Date] = []
    var isEnglishLanguageSelected:Bool = true
}
