//
//  BaseUITextField.swift
//  Esaad
//
//  Created by Usman on 16/01/2019.
//  Copyright © 2019 Faraz Haider. All rights reserved.
//

import Foundation
import DatePickerDialog
import MOLH

@IBDesignable
class BaseUITextField: UITextField {
    let border = CALayer()
    
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.text = ""
        
        self.delegate = self
        updateRightView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.text = ""
        
        self.delegate = self
        updateRightView()
    }
    

    @IBInspectable var WidgetType: String? {
        willSet {
            // Ensure user enters a valid shape while making it lowercase.
            // Ignore input if not valid.
            if let newWidget = WidgetElement(rawValue: newValue ?? "") {
                widget = newWidget
                
            }
        }
        
    }
    
    var widget                           = WidgetElement.Default
    
    /// Sets the placeholder color
    @IBInspectable public var placeholderColor: UIColor = .lightGray {
        didSet {
            let placeholderStr = placeholder ?? ""
            attributedPlaceholder = NSAttributedString(string: placeholderStr, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        }
    }
    
    public override var placeholder: String? {
        didSet {
            let placeholderStr = placeholder ?? ""
            attributedPlaceholder = NSAttributedString(string: placeholderStr, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        }
    }
    
    @IBInspectable var rightImage : UIImage? {
        didSet {
            updateRightView()
        }
    }
    
    @IBInspectable var rightPadding : CGFloat = 0 {
        didSet {
            updateRightView()
        }
    }
  
 
    // MARK: - Layout
    override public func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    private func updateRightView() {
        if let image = rightImage {
            rightViewMode = .always
            
            var width : CGFloat = 0
            
            if Singleton.sharedInstance.isEnglishLanguageSelected{
                width = rightPadding - 10
                self.semanticContentAttribute = .forceLeftToRight
            }else{
                width = rightPadding + 10
                self.semanticContentAttribute = .forceRightToLeft
            }
            // assigning image
            let imageView = UIImageView(frame: CGRect(x: width , y: 0, width: 16, height: 16))
            imageView.image = image
            
            if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                width -= 5
            }
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 16)) // has 5 point higher in width in imageView
            view.addSubview(imageView)
            
            
            rightView = view
            
        } else {
            // image is nill
            rightViewMode = .never
        }
    }
    
    private func datePickerTapped() {
        let datePicker = DatePickerDialog(locale :Locale(identifier: MOLHLanguage.currentLocaleIdentifier()))
        
        datePicker.show(Utility.getLocalizedString("Date Picker"), doneButtonTitle: Utility.getLocalizedString("Done"), cancelButtonTitle: Utility.getLocalizedString("Cancel"), datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = DateFormats.dd_MM_YYYY.rawValue
                formatter.locale = Locale(identifier: MOLHLanguage.currentAppleLanguage())
                self.text = formatter.string(from: dt)
            }
        }
    }
    
    
}


extension BaseUITextField : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // figure out what the new string will be after the pending edit
       
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("focused")
       
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("lost focus")
       
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if widget == .DatePicker{
            
            self.datePickerTapped()
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
