//
//  Date+Extension.swift
//  Esaad
//
//  Created by Faraz Haider on 11/15/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import Foundation
import MOLH

extension Date {
    static func getFormattedDate(string: String , formatter:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        dateFormatterPrint.locale = Locale.init(identifier: MOLHLanguage.currentLocaleIdentifier())
        let date: Date? = dateFormatterGet.date(from: string)
        return dateFormatterPrint.string(from: date!);
    }
    
    static func getFormattedDate(string: String , formatter:String, format: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format
        dateFormatterPrint.locale = Locale.init(identifier: MOLHLanguage.currentLocaleIdentifier())
        let date: Date? = dateFormatterGet.date(from: string)
        return dateFormatterPrint.string(from: date!);
    }

}
