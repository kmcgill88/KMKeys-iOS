//
//  KMKeys.swift
//  KMKeys
//
//  Created by McGills on 4/17/17.
//  Copyright © 2017 McGill DevTech, LLC. All rights reserved.
//

import UIKit

open class KMKeys: UIView {
    
    open let textField:KMTextField = KMTextField()
    open let toolbar:UIToolbar = UIToolbar()
    open var animationSpeed = 0.15
    open override var frame: CGRect {
        didSet {
            textField.frame = CGRect.init(x: 0, y: 0, width: defaultFrame.size.width, height: textFieldHeight)
            toolbar.frame = CGRect.init(x: 0, y: textFieldHeight, width: defaultFrame.size.width, height: toolbarHeight)
            tapView.frame = CGRect.init(x: 0, y: 0, width: appWindow.bounds.size.width, height: appWindow.bounds.size.height)
        }
    }
    
    private let tapView:UIView = UIView()
    private let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(KMKeys.done))
    private let cancelBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(KMKeys.cancel))
    private let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

    private var textFieldHeight:CGFloat = 30.0
    private var toolbarHeight:CGFloat  = 44.0
    private var completionHandler:(_ text:String?) -> Void = {_ in }
    private var appWindow:UIWindow {
        get {
            return UIApplication.shared.keyWindow!
        }
    }
    private var defaultFrame:CGRect {
        get {
            return CGRect(x: 0, y: appWindow.bounds.size.height, width: appWindow.bounds.size.width, height: textFieldHeight + toolbarHeight)
        }
    }

    
    convenience public init() {
        self.init(frame: CGRect.zero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public func done() {
        toggle()
        completionHandler(textField.text)
    }
    
    public func cancel() {
        toggle()
    }
    
    public class func show(completionHandler:@escaping (_ text:String?) -> Void) {
        KMKeys().show(completionHandler: completionHandler)
    }
    
    public func show(completionHandler:@escaping (_ text:String?) -> Void) {
        self.completionHandler = completionHandler
        toggle()
    }
    
    public func toggle() {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
            self.removeFromSuperview()
            tapView.removeFromSuperview()
        } else {
            appWindow.addSubview(tapView)
            appWindow.addSubview(self)
            textField.becomeFirstResponder()
        }
    }
    
    public func setToolbarItems(items: [KMKeyBarButtonItem]) {
        toolbar.items = items
    }
    
    public func setToolbarItemsTintColor(color: UIColor) {
        for item in self.toolbar.items ?? [] {
            item.tintColor = color
        }
    }
    
    private func setup() {
        let fixedSpace = KMKeyBarButtonItem.fixedSpace()
        self.toolbar.items = [fixedSpace, cancelBarButton, flexibleSpace, doneBarButton, fixedSpace]
        self.tapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cancel)))
        
        self.frame = defaultFrame
        self.addSubview(textField)
        self.addSubview(toolbar)

        NotificationCenter.default.addObserver(self, selector: #selector(KMKeys.keyboardDidChangeFrame(notification:)), name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KMKeys.keyBoardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KMKeys.keyBoardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardDidChangeFrame(notification: NSNotification) {
        let frame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.frame = self.defaultFrame.offsetBy(dx: 0, dy: -frame.height - self.frame.height)
    }
    
    @objc private func keyBoardWillShow(notification: NSNotification) {
        let frame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        moveViewWithKeyboard(height: -frame.height)
    }

    @objc private func keyBoardWillHide(notification: NSNotification) {
        moveViewWithKeyboard(height: 0)
    }
    
    private func moveViewWithKeyboard(height: CGFloat) {
        UIView.animate(withDuration: animationSpeed, animations: {
            self.frame = self.defaultFrame.offsetBy(dx: 0, dy: height - self.frame.height)
        })
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
