//
//  UITextView+Extension.swift
//  Esaad
//
//  Created by Faraz Haider on 12/4/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit
import MOLH

extension UITextView{
    open override func awakeFromNib() {
        if MOLHLanguage.currentAppleLanguage() == "en" {
            self.textAlignment = .left
        }else{
            self.textAlignment = .right
        }
    }
        
        /// Resize the placeholder when the UITextView bounds change
        override open var bounds: CGRect {
            didSet {
                if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                    placeholderLabel.sizeToFit()
                }
            }
        }
        
        /// The UITextView placeholder text
        @IBInspectable public var placeholder: String? {
            get {
                var placeholderText: String?
                
                if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                    placeholderText = placeholderLabel.text
                }
                
                return placeholderText
            }
            set {
                if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                    placeholderLabel.text = newValue
                    placeholderLabel.sizeToFit()
                } else {
                    self.addPlaceholder(text: newValue)
                }
            }
        }
        
        @IBInspectable public var placeholderColor: UIColor {
            get {
                var placeholderColor = UIColor.lightGray
                
                if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                    placeholderColor = placeholderLabel.textColor
                }
                
                return placeholderColor
            }
            set {
                if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                    placeholderLabel.textColor = newValue
                } else {
                    self.addPlaceholder(color: newValue)
                }
            }
        }
        
        @IBInspectable public var placeholderFont: UIFont {
            get {
                var placeholderFont = font
                
                if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                    placeholderFont = placeholderLabel.font
                }
                
                return placeholderFont!
            }
            set {
                if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                    placeholderLabel.font = newValue
                    placeholderLabel.sizeToFit()
                } else {
                    self.addPlaceholder(font: newValue)
                }
            }
        }
        
        @IBInspectable public var placeholderTopInset: CGFloat {
            get {
                var inset: CGFloat = textContainerInset.top - 2
                
                if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                    inset = placeholderLabel.frame.origin.y
                }
                
                return inset
            }
            set {
                if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                    placeholderLabel.frame.origin.y = newValue
                } else {
                    self.addPlaceholder(topInset: newValue)
                }
            }
        }
        
        @IBInspectable public var placeholderLeftInset: CGFloat {
            get {
                var inset: CGFloat = textContainer.lineFragmentPadding
                
                if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                    inset = placeholderLabel.frame.origin.x
                }
                
                return inset
            }
            set {
                if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                    placeholderLabel.frame.origin.x = newValue
                } else {
                    self.addPlaceholder(leftInset: newValue)
                }
            }
        }
        
        /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
        ///
        /// - Parameter textView: The UITextView that got updated
    @objc public func textViewDidChange(_ textView: UITextView) {
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderLabel.isHidden = self.text.characters.count > 0
            }
        }
        
        /// Adds a placeholder UILabel to this UITextView
        private func addPlaceholder(text: String? = "", font: UIFont? = nil, color: UIColor? = nil, topInset: CGFloat? = nil, leftInset: CGFloat? = nil) {
            let placeholderLabel = UILabel()
            
            placeholderLabel.text = text
            placeholderLabel.font = font ?? self.font
            placeholderLabel.textColor = color ?? UIColor.lightGray
            placeholderLabel.sizeToFit()
            placeholderLabel.frame.origin.y = topInset ?? textContainerInset.top - 2
            placeholderLabel.frame.origin.x = leftInset ?? textContainer.lineFragmentPadding
            
            placeholderLabel.tag = 100
            
            placeholderLabel.isHidden = self.text.characters.count > 0
            
            self.addSubview(placeholderLabel)
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(textViewDidChange),
                                                   name: NSNotification.Name.UITextViewTextDidChange,
                                                   object: nil)
        }
}
