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
    
    private func getPlaceholderAttributes() -> [NSAttributedStringKey:Any] {
        var attributes:[NSAttributedStringKey : Any] = [:]
        
        if let color = self.placeholderColor {
            attributes[NSAttributedStringKey.foregroundColor] = color
        }
        
        if let validFont = self.font {
            attributes[NSAttributedStringKey.font] = validFont
        }
        return attributes
    }
}
