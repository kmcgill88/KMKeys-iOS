//
//  KMKeys.swift
//  KMKeys
//
//  Created by McGills on 4/17/17.
//  Copyright © 2017 McGill DevTech, LLC. All rights reserved.
//
import UIKit

open class KMKeys: UIView {
    
    open let textField:UITextField = UITextField()
    open let toolbar:UIToolbar = UIToolbar()
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
    private let ANIMATION_SPEED = 0.25
    
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
        self.toolbar.items = [cancelBarButton, flexibleSpace, doneBarButton]
        self.tapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cancel)))
        
        self.frame = defaultFrame
        self.addSubview(textField)
        self.addSubview(toolbar)

        NotificationCenter.default.addObserver(self, selector: #selector(KMKeys.keyboardDidChangeFrame(notification:)), name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KMKeys.keyBoardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func moveViewWithKeyboard(height: CGFloat) {
        UIView.animate(withDuration: ANIMATION_SPEED, animations: {
            self.frame = self.defaultFrame.offsetBy(dx: 0, dy: height - self.frame.height)
        })
    }
    
    @objc private func keyboardDidChangeFrame(notification: NSNotification) {
        let frame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        moveViewWithKeyboard(height: -frame.height)
    }

    @objc private func keyBoardWillHide(notification: NSNotification) {
        moveViewWithKeyboard(height: 0)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

public enum KMKeyBarButtonItemType {
    case action, cancel, done, flexibleSpace, textInput
}

public class KMKeyBarButtonItem: UIBarButtonItem {
    
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
    
    @objc private func barButtonItemTextInput(barButtonItem: KMKeyBarButtonItem) {
        if let textFieldText = kmKeys?.textField.text, let barButtonItemTitle = barButtonItem.title {
            kmKeys?.textField.text = textFieldText + barButtonItemTitle
        }
    }
    
    @objc private func barButtonItemAction(barButtonItem: KMKeyBarButtonItem) {
        actionHandler?(self.kmKeys)
    }
}
