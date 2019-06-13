//
//  String+Extension.swift
//  Esaad
//
//  Created by Faraz Haider on 10/15/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import Foundation
import MOLH

public extension String {
    
    public func toDouble() -> Double? {
        return Double(self)
    }
    
    public func toFloat() -> Float? {
        return Float(self)
    }
    
    public func toInt() -> Int? {
        return Int(self)
    }
    
    var localized: String {
            return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    public var replacedEnglishWithArabicDigits: String {
        var str = self
        if Singleton.sharedInstance.isEnglishLanguageSelected {
            return self
        }else{
        let map = ["٠": "0",
                   "١": "1",
                   "٢": "2",
                   "٣": "3",
                   "٤": "4",
                   "٥": "5",
                   "٦": "6",
                   "٧": "7",
                   "٨": "8",
                   "٩": "9"]
        map.forEach { str = str.replacingOccurrences(of: $1, with: $0) }
        return str
        }
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    var NumerWithDecimalPoint : String{

        if !self.isEmpty{
            let numberFormatter = NumberFormatter()
            numberFormatter.locale = Locale.init(identifier: MOLHLanguage.currentLocaleIdentifier())
            numberFormatter.decimalSeparator = "." //decimal separator
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            numberFormatter.maximumFractionDigits = 2
            numberFormatter.roundingMode = .floor
            
            if let number = numberFormatter.number(from: self) {
                return  numberFormatter.string(from: number) ?? ""
            }
        }
        return ""
    }
    
    func safeAddingPercentEncoding(withAllowedCharacters allowedCharacters: CharacterSet) -> String? {
        // using a copy to workaround magic: https://stackoverflow.com/q/44754996/1033581
        let allowedCharacters = CharacterSet(bitmapRepresentation: allowedCharacters.bitmapRepresentation)
        return addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
    
    public func to12HourTime() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss "
        dateFormatter.locale = Locale(identifier:"en")
        //--ww dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.locale = Locale(identifier: MOLHLanguage.currentLocaleIdentifier())
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    
    
    public func toFormatedDateString(_ format : String = "dd MMM yyyy") -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier:"en")
        //dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        //--ww dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = format
        dateFormatter.locale =   Locale(identifier: MOLHLanguage.currentLocaleIdentifier())
        return dateFormatter.string(from: date)
    }
    
    
    public func toDateString(_ format : String = "dd MMM yyyy") -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"en")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        //dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        //--ww dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.locale =  Locale(identifier: MOLHLanguage.currentLocaleIdentifier())
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    
    public func toDate(_ format : String = "yyyy-MM-dd") -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale =  Locale(identifier: MOLHLanguage.currentLocaleIdentifier())
        return dateFormatter.date(from: self) ?? Date()
    }
    
    
//    public func getServerDate() -> String{
//        let inputFormatter = DateFormatter()
//        inputFormatter.dateFormat = DateFormats.MM_dd_YYYY.rawValue
//        let showDate = inputFormatter.date(from: self)
//        inputFormatter.dateFormat = DateFormats.YYYY_MM_dd.rawValue
//        let resultString = inputFormatter.string(from: showDate!)
//        return resultString
//    }
    
    public func serverDateFormat(_ format : String = "yyyy-MM-dd") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"en")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        //dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        //--ww dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.locale =  Locale(identifier:"en")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    public func getServerDate() -> String{
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = DateFormats.dd_MM_YYYY.rawValue
        let showDate = inputFormatter.date(from: self)
        inputFormatter.dateFormat = DateFormats.YYYY_MM_dd.rawValue
        let resultString = inputFormatter.string(from: showDate!)
        return resultString
    }
    
    func dateFrom24HourTo12Hour() -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"en")
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.locale =  Locale(identifier: MOLHLanguage.currentLocaleIdentifier())
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
        
        
    }
    /*   public var localized: String {
     // the; translators team, they don’t deserve comments
     return localoizedFromPlist.sharedInstance.localize(string: self)
     }
     */
    // Validate if the string is empty
    public func isEmptyStr()->Bool {
        return (self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "");
    }
    
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
    // Validate if the email is correct
    public func isValidEmail()->Bool {
        let emailRegex:String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return predicate.evaluate(with: self);
    }
    
    // Validate if the url is correct
    public func isValidUrl() -> Bool {
        let regexURL: String = "(http://|https://)?((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let predicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", regexURL)
        return predicate.evaluate(with: self)
    }
    
    public func isValidPhoneNumber() -> Bool {
//        let regexURL: String = "^(?:\\+971|00971|0)?(?:50|51|52|55|56|2|3|4|6|7|9)\\d{7}$"
        let regexURL: String = "^(0|971)(50|52|55|56|54|58)[0-9]{7}$"//"^(?:\\+971|0(0971)?)(?:[234679]|5[01256])[0-9]{7}$"
        let predicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", regexURL)
        return predicate.evaluate(with: self)
    }
    
    var isArabic: Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", "^[\\p{Arabic}]+$")
        return predicate.evaluate(with: self)
    }
    
    public var replacedArabicDigitsWithEnglish: String {
        var str = self
        let map = ["٠": "0",
                   "١": "1",
                   "٢": "2",
                   "٣": "3",
                   "٤": "4",
                   "۴":"4",
                   "٥": "5",
                   "٦": "6",
                   "٧": "7",
                   "٨": "8",
                   "٩": "9"]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
    
    //^(?:\+971|00971|0)?(?:50|51|52|55|56|2|3|4|6|7|9)\d{7}$
    
    // Validate if given input is numeric
    public func isNumeric() -> Bool {
        return Double(self) != nil;
    }
    
    // Validate if string has minimum characters
    public func isValidForMinChar(noOfChar:Int) -> Bool {
        return (self.utf16.count >= noOfChar);
    }
    
    // Validate if string has less than or equal to maximum characters
    public func isValidForMaxChar(noOfChar:Int) -> Bool {
        return (self.utf16.count <= noOfChar);
    }
    
    // Validate the string for given regex
    public func isValidForRegex(regex:String) -> Bool {
        let predicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return predicate.evaluate(with: self);
    }
    
    //extension for getting the domain name from a string
    public func getDomain() -> String? {
        guard let url = URL(string: self) else { return nil }
        return url.host
    }
    
    var isAlphabetOnly: Bool {
        return !isEmpty && range(of: "[^a-zA-Z ]", options: .regularExpression) == nil
    }
    
    var isAlphanumeric: Bool {
        
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    var isContainsLetters : Bool{
        let letters = CharacterSet.letters
        return self.rangeOfCharacter(from: letters) != nil
    }
    
    var isContainNumbers : Bool{
        let decimalCharacters = CharacterSet.decimalDigits
        return self.rangeOfCharacter(from: decimalCharacters) != nil
    }
    
    var isContainsWhitespace : Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
    func replace(_ string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    func removeWhitespace() -> String {
        return self.replace(" ", replacement: "%20")
    }
}


public class StringClass {
    
    
    static func trimStr(str : String) ->String{
        
        return str .trimmingCharacters(in: .whitespacesAndNewlines)
        
    }
    
    static func formatNumberAsCurrency(number : Int64)-> String{
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let str = numberFormatter .string(from: NSNumber(value: number))
        return str!
        
    }
    
    static func formatNumberAsCurrencyWithAddString(firstStr : String,number : Int64, lastStr : String)-> String{
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let noStr = numberFormatter .string(from: NSNumber(value: number))
        
        let str = firstStr + noStr! + lastStr
        return str
        
    }
    
    
    
    
    
    //    static func getAttributedStringForHTMLWithFont( htmlStr : String , textSize : Int , fontName : String )->NSAttributedString?
    //    {
    //        var htmlStr = htmlStr
    //        do {
    //
    //            if htmlStr .isEmpty{
    //                htmlStr = "<p></p>"
    //
    //            }
    //
    //            let str = "<div style=\"color:#5A5A5A; font-size: \(textSize)px\"><font face=\"\(fontName)\">\(htmlStr)</font></div>"
    //            let data  = str .data(using: String.Encoding.unicode)!
    //            let attributedOptions : [String: Any] = [
    //                NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
    //                NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue
    //            ]
    //
    //
    //            let attributedStr = try NSAttributedString.init(data: data, options: attributedOptions, documentAttributes: nil)
    //            return attributedStr
    //        }
    //        catch {
    //            return nil
    //        }
    //    }
    
    
    static func sanitizeStr (str : String) -> String{
        
        
        let notAllowedCharacters = NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+ ").inverted
        
        let resultSTR = str.components(separatedBy: notAllowedCharacters).joined(separator: "")
        
        debugPrint(resultSTR)
        
        return resultSTR
        
    }
    
    static func containSpecialChars(str : String)->Bool{
        
        let notAllowedCharacters = NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ").inverted
        
        let resultSTR = str.components(separatedBy: notAllowedCharacters).joined(separator: "")
        
        debugPrint(resultSTR)
        
        if resultSTR.count  == str.count
        {
            return false;
        }
        else
        {
            return true;
        }
        
        
    }
    
    static func containOnlyNumbers(str : String)->Bool{
        let notAllowedCharacters = NSCharacterSet(charactersIn: "01234567890").inverted
        
        let resultSTR = str.components(separatedBy : notAllowedCharacters).joined(separator: "")
        
        debugPrint(resultSTR)
        
        if resultSTR.count  == str.count
        {
            return false;
        }
        else
        {
            return true;
        }
        
    }
    
    
    
    static func isEmptyString(str : String) -> Bool{
        
        let  string = str .trimmingCharacters(in: .whitespacesAndNewlines)
        
        return (string == "")  ? true : false
        
    }
    
    static func stringWithoutWhitespaces(str : String)->String{
        
        let words   = str.components(separatedBy: .whitespacesAndNewlines)
        let nospacestring = words .joined(separator: "")
        return nospacestring
        
    }
}
extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension UILabel {
    func setHTMLFromString(text: String) {
        let modifiedFont = NSString(format:"<span style=\"font-family: \(self.font!.fontName); font-size: \(self.font!.pointSize)\">%@</span>" as NSString, text)
        
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: String.Encoding.unicode.rawValue, allowLossyConversion: true)!,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        
        self.attributedText = attrStr
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    
    enum RegularExpressions: String {
        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
    }
    
    func isValid(regex: RegularExpressions) -> Bool {
        return isValid(regex: regex.rawValue)
    }
    
    func isValid(regex: String) -> Bool {
        
//        let regex = try! NSRegularExpression(pattern: regex, options: .caseInsensitive)
//        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return emailTest.evaluate(with: testStr)
        
        let matches = range(of: regex, options: .regularExpression)
        return matches != nil
        
    }
    
    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter{CharacterSet.decimalDigits.contains($0)}
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
    
    func makePhoneCall() {
        if isValid(regex: .phone) {
//            if let url = URL(string: "tel://\(self.onlyDigits())"), UIApplication.shared.canOpenURL(url)
            if let url = URL(string: "tel://\(self))"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
}
