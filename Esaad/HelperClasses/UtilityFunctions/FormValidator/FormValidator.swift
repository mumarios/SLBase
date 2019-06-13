//
//  FormValidator.swift


import UIKit
public class FormValidator {
    
    func validateForm() {
        
    }
    
    
    func validateText(_ text : String? , rules : [FormError]) throws -> String {
        
        for rule in rules{
            
            switch rule {
            case .empty( let name):
                guard let tx = text , !tx.isEmptyStr() else {
                    throw FormError.empty(name: name)
                }
                break
            case .onlyAlphabets(let name):
                guard let tx = text , tx.isAlphabetOnly else {
                    throw FormError.onlyAlphabets(name: name)
                }
                break
            case .minimumLength(let name, let value):
                print(name, value)
                guard let tx = text , tx.count >= value else {
                    throw FormError.minimumLength(name: name, len: value)
                }
                break
            case .maximumLength(let name , let value):
                print(name ,value)
                guard let tx = text , tx.count <= value else {
                    throw FormError.maximumLength(name: name, len: value)
                }
                break
            case .validEmail:
               guard let tx = text , tx.isValidEmail() else {
                    throw FormError.validEmail
                }
                break
                
            case .onlyNumbers:
                guard let tx = text , tx.isValidPhoneNumber() else {
                    throw FormError.invalidNumber
                }
                break
                
            case .shouldAlphaNumeric(let name):
                guard let tx = text , tx.isContainNumbers , tx.isContainsLetters else {
                    throw FormError.shouldAlphaNumeric(name: name)
                }
                break
                
            case .isContainsWhitespace(let name):
                guard let tx = text , !tx.isContainsWhitespace else {
                    throw FormError.isContainsWhitespace(name: name)
                }
                break
            case .validForPasswordRegex(let name):
                //
                //"^(?=.*[0-9]+.*)(?=\\b)(?=.*[A-Z]+.*)(?=.*[@$!%*?&])[0-9a-zA-Zd@$!%*?&]{6,}$"
                guard let tx = text , tx.isValid(regex: "^(?=.*[0-9]+.*)(?=\\b)(?=.*[A-Z]+.*)(?=.*[@_-])[0-9a-zA-Zd@_-]{8,}$") else {
                    throw FormError.validForPasswordRegex(name: name)
                }
                break;
            default:
                break
            }
            
            
        }
        
        return text ?? ""
    }
    
    
    func validateName(title: String , text : String) -> (Bool , String) {
        do {
        let name = try validateText(text, rules: [.empty(name:title),.onlyAlphabets(name: text), .minimumLength(name: title, len: 3), .maximumLength(name : title , len: 30)])
             return (true,name)
        }catch{
          return (false,"\(error)")
        }
    }
    
    
    func validateEmptyText(title: String , text : String) -> (Bool , String) {
        do {
            let name = try validateText(text, rules: [.empty(name:title)])
            return (true,name)
        }catch{
            return (false,"\(error)")
        }
    }
    
    
    func validateEmployeeID(title: String = "Employee ID".localized, text : String) -> (Bool , String) {
        do {
            let empID = try validateText(text, rules: [.empty(name:title) , .maximumLength(name: title, len: Constants.maximumEmpID)])

            return (true, empID)
        }catch{
            return (false,"\(error)")
        }
    }
    
    func validateEmail(title: String = "Email".localized, text : String) -> (Bool , String) {
          do {
         let email = try validateText(text, rules: [.validEmail])
             return (true, email)
          }catch let error{
          return (false,"\(error)")
        }
    }
    
    func validateCode(title: String = "Code".localized, text : String) -> (Bool , String) {
        do {
            let code = try validateText(text, rules: [.empty(name:title)])
            return (true, code)
        }catch{
            return (false,"\(error)")
        }
    }
    
    
    func validatePhoneNo(title: String = "Phone No".localized, text : String) -> (Bool , String) {
        do {
            let phone = try validateText(text, rules: [.onlyNumbers , .minimumLength(name: title, len: Constants.minimumLengthNumber) , .maximumLength(name: title, len: Constants.maximumLengthNumber)])
            return (true, phone)
        }catch{
            return (false,"\(error)")
        }
    }
    
    
    func validatePassword(title: String = "Password".localized, text : String) -> (Bool , String) {
        do {
            
//            let pwd = try validateText(text, rules: [.empty(name:title), .minimumLength(name: title, len: Constants.minimumLengthPwd) , .maximumLength(name: title, len: Constants.maximumLengthPwd), .shouldAlphaNumeric(name: title), .isContainsWhitespace(name: title)])
            
            let pwd = try validateText(text, rules: [.empty(name:title), .validForPasswordRegex(name: title)])
            return (true, pwd)
        }catch{
            return (false,"\(error)")
        }
    }
    
    func validateConfirmEmail(title: String = "Confirm Email".localized, email : String , cEmail : String ) -> (Bool , String) {
        if cEmail.isEmptyStr() {
            return (false,"\(title)"+"must not be empty".localized)
        }
        else if !(cEmail.elementsEqual(email)) {
            return (false,"Email and confirm email are not same".localized)
            
        }else{
            do {
                _ = try validateText(email, rules: [.empty(name:title), .validEmail])
                return (true, "Email matched and is valid".localized)
            }catch let error{
                return (false, "\(error)")
            }
            
        }
    }
    
    func validateConfirmPassword(title: String = "Confirm New Password".localized, pwd : String , cpwd : String ) -> (Bool , String) {
        if cpwd.isEmptyStr() {
            return (false,"\(title)"+"must not be empty".localized)
        }
        else if !(cpwd.elementsEqual(pwd)) {
             return (false,"Password and confirm password are not same".localized)
         
        } else {
        do {
            
         let pwd = try validateText(pwd, rules: [.empty(name:title), .validForPasswordRegex(name: title)])
            return (true, pwd)
         }catch{
            return (false,"\(error)")
         }
        
        }
    }
    
    
    func validateAcceptTerm(title: String = "Accept Terms".localized, status : Bool) -> (Bool , String) {
        if status == true {
            return (true, "")
        } else {
            return (false,"Kindly accept terms and conditions".localized)
        }
    }
    
    func validateFName(title: String = "First Name".localized ,text : String) throws -> String {
       return try validateText(text, rules: [.empty(name:title),.onlyAlphabets(name: title), .minimumLength(name: title, len: 3), .maximumLength(name : title , len: 10)])
    }
  
    
    func validateLName(title: String = "Last Name".localized , text : String) throws -> String {
      return try validateText(text, rules: [.empty(name:title),.onlyAlphabets(name: title), .minimumLength(name: title, len: 3), .maximumLength(name : title , len: 10)])
    }
    
    func validateEmailWithThrow(title: String = "Email".localized, text : String) throws -> String {
        return try validateText(text, rules: [.empty(name:title), .validEmail])
    }
    
    
    func validatePasswordWithThrow(title: String = "Password".localized, text : String) throws -> String {
        return try validateText(text, rules: [.empty(name:title), .minimumLength(name: title, len: 6) , .maximumLength(name: title, len: 12) , .shouldAlphaNumeric(name: title)])
    }
}
