//
//  ViewController.swift
//  KMKeys
//
//  Created by Kevin McGill on 04/17/2017.
//  Copyright (c) 2017 Kevin McGill. All rights reserved.
//

import UIKit
import KMKeys

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    @IBAction func pressed(_ sender: UIButton) {
        
        // Short hand, default settings
        //
        KMKeys.show() { (text:String?) in
            self.label.text = text
        }
    }
    
    @IBAction func pressedCusomtized(_ sender: Any) {
        
        let keys = KMKeys()
        
        // Change Default speed (0.15)
        //
        keys.animationSpeed = 0.05
        
        // Customize the text field
        //
        keys.textField.textAlignment = .center
        keys.textField.placeholder = "Placeholder Text Here"
//        keys.textField.font = UIFont(name: "", size: CGFloat.pi)
//        keys.textField.placeholderColor = UIColor.init(white: 255/255, alpha: 0.75)
        keys.textField.backgroundColor = .brown
        keys.textField.textColor = .white
        keys.textField.tintColor = .white
        keys.textField.keyboardType = .decimalPad
        keys.textField.keyboardAppearance = .dark
        
        // Customize the toolbar
        //
        keys.toolbar.barTintColor = .brown
        
        // KMKeyBarButtonItemType.flexibleSpace, .cancel, .done
        // Mostly normal buttons, except can set custom titles
        //
        let flexibleSpace = KMKeyBarButtonItem.flexibleSpace() //<-- Shortcut helper
        let cancelBarButton = KMKeyBarButtonItem(title: "Never Mind", style: .plain, action: .cancel, kmKeys: keys)
        let doneBarButton = KMKeyBarButtonItem(title: "Fire!!!", style: .done, action: .done, kmKeys: keys)
        // let cancelBarButton = KMKeyBarButtonItem.cancel() //<-- Shortcut helper, if custom name not needed
        // let doneBarButton = KMKeyBarButtonItem.done() //<-- Shortcut helper, if custom name not needed
        
        // KMKeyBarButtonItemType.textInput
        // When you want a toolbar button's title to append to the textField
        //
        let plusButton = KMKeyBarButtonItem(title: "+", style: UIBarButtonItemStyle.plain, action: KMKeyBarButtonItemType.textInput, kmKeys: keys)
        let minusButton = KMKeyBarButtonItem(title: "-", style: .plain, action: .textInput, kmKeys: keys)
        let commaButton = KMKeyBarButtonItem(title: ",", style: .plain, action: .textInput, kmKeys: keys)
        
        // KMKeyBarButtonItemType.action
        // When you want a button to do
        let actionBarButton = KMKeyBarButtonItem(title: "Custom Action", style: .plain, action: KMKeyBarButtonItemType.action, kmKeys: keys, actionHandler: { (_ kmKeys:KMKeys?) in
            
            // Do your custom logic here, in the actionHandler.
            //
            if let keys = kmKeys {
                keys.textField.text = "KMKeys!!!!"
            }
        })
        
        let fixedSpace = KMKeyBarButtonItem.fixedSpace() //<-- Shortcut helper, by default size is 2% of window width or 5 if window is nil
        keys.setToolbarItems(items: [fixedSpace, cancelBarButton, flexibleSpace, plusButton, commaButton, minusButton, actionBarButton, flexibleSpace, doneBarButton, fixedSpace])
        keys.setToolbarItemsTintColor(color: .white)
        
        keys.show() { (text:String?) in
            self.label.text = text
        }
    }
}
