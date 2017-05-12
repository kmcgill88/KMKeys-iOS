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
            
        }
    }
    
    open var placeholderColor: UIColor? {
        get {
            return self.placeholderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder ?? "", attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }

}
