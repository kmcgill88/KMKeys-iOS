//
//  KMKeyBarButtonItem.swift
//  Pods
//
//  Created by Kevin McGill on 5/11/17.
//
//

import UIKit

public enum KMKeyBarButtonItemType {
    case action, cancel, done, flexibleSpace, textInput
}

open class KMKeyBarButtonItem: UIBarButtonItem {
    
    public typealias ActionHandler = (_ kmKeys:KMKeys?) -> Void
    private var actionHandler: ActionHandler?
    
    private var kmKeys:KMKeys?
    
    public convenience init(title: String?, style: UIBarButtonItemStyle, action: KMKeyBarButtonItemType, kmKeys: KMKeys, actionHandler:ActionHandler? = nil) {
        if action == .flexibleSpace {
            self.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        } else {
            self.init(title: title, style: style, target: nil, action: nil)
        }
        
        self.kmKeys = kmKeys
        self.target = kmKeys
        
        switch action {
        case .done:
            self.action = #selector(kmKeys.done)
        case .cancel:
            self.action = #selector(kmKeys.cancel)
        case .textInput:
            self.target = self
            self.action = #selector(KMKeyBarButtonItem.barButtonItemTextInput(barButtonItem:))
        case .action:
            self.actionHandler = actionHandler
            self.target = self
            self.action = #selector(KMKeyBarButtonItem.barButtonItemAction(barButtonItem:))
        default:
            break
        }
    }
    
    public class func done() -> KMKeyBarButtonItem {
        return self.init(barButtonSystemItem: .done, target: nil, action: #selector(KMKeys.done))
    }
    
    public class func cancel() -> KMKeyBarButtonItem {
        return self.init(barButtonSystemItem: .cancel, target: nil, action: #selector(KMKeys.cancel))
    }
    
    public class func flexibleSpace() -> KMKeyBarButtonItem {
        return self.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }
    
    public class func fixedSpace() -> KMKeyBarButtonItem {
        let fixedSpaceBarButtonItem = KMKeyBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
        var fixedSize:CGFloat = 5.0
        if let goodWindow = UIApplication.shared.keyWindow {
            fixedSize = goodWindow.bounds.size.width * 0.02
        }
        
        fixedSpaceBarButtonItem.width = fixedSize
        
        return fixedSpaceBarButtonItem
    }
    
    @objc private func barButtonItemTextInput(barButtonItem: KMKeyBarButtonItem) {
        if let textFieldText = kmKeys?.textField.text, let barButtonItemTitle = barButtonItem.title {
            kmKeys?.textField.text = textFieldText + barButtonItemTitle
        }
    }
    
    @objc private func barButtonItemAction(barButtonItem: KMKeyBarButtonItem) {
        actionHandler?(self.kmKeys)
    }
}
