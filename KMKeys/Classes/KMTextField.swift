//
//  KMTextField.swift
//  Pods
//
//  Created by Kevin McGill on 5/11/17.
//
//

import UIKit

open class KMTextField: UITextField {
    
    open override var font: UIFont? {
        didSet {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder ?? "", attributes: getPlaceholderAttributes())
        }
    }
    
    open var placeholderColor: UIColor? {
        didSet {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder ?? "", attributes: getPlaceholderAttributes())
        }
    }
    
    private func getPlaceholderAttributes() -> [String:Any] {
        var attributes:[String : Any] = [:]
        
        if let color = self.placeholderColor {
            attributes[NSForegroundColorAttributeName] = color
        }
        
        if let validFont = self.font {
            attributes[NSFontAttributeName] = validFont
        }
        return attributes
    }
}
