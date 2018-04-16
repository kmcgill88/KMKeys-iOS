/*
 Copyright (c) 2017-2018 Kevin McGill <kevin@mcgilldevtech.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

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
