//
//  FormErrors.swift


import UIKit


enum FormError: Error {
    case empty(name : String)
    case onlyAlphabets(name : String )
    case minimumLength(name : String, len : Int)
    case maximumLength(name : String, len : Int)
    case validEmail
    case onlyNumbers
    case invalidNumber
    case shouldAlphaNumeric(name : String)
    case isContainsWhitespace(name : String)
    case validForPasswordRegex (name: String)
    case unknown
}


extension FormError: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .empty(let name): return "Please Enter".localized + "\(name)"
        case .onlyAlphabets(let name): return "\(name)" + "can only contain alphabets".localized
        case .minimumLength(let name, let val): return "\(name) "+" minimum length should be".localized+" \(val)"
        case .maximumLength(let name, let val): return "\(name) "+"maximum length should be".localized+" \(val)"
        case .validEmail: return "Enter a valid email e.g.(jhon@abc.com)".localized
        case .invalidNumber: return "Mobile Number should be 9715xxxxxxxx".localized
        case .onlyNumbers: return "Kindly provide valid mobile number".localized
        case .shouldAlphaNumeric(let name) : return "\(name) "+"should contains at least one number and at least one alphabet character".localized
        case .isContainsWhitespace(let name): return "\(name) "+"should not contain white spaces".localized
        case .validForPasswordRegex(let _): return Utility.getLocalizedString("passwordPolicyError")
        case .unknown : return "Unknown validation".localized
        }
    }
}


