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
        let keys = KMKeys()
        keys.show(completionHandler: { (text:String?) in
            self.label.text = text
        })
    }
    
    @IBAction func pressedCusomtized(_ sender: Any) {
        
        let keys = KMKeys()
        
        // Customize the text field
        //
        keys.textField.textAlignment = .center
        keys.textField.placeholder = "Placeholder Text Here"
        keys.textField.backgroundColor = .brown
        keys.textField.textColor = .white
        keys.textField.tintColor = .white
        keys.textField.keyboardType = .decimalPad
        keys.textField.keyboardAppearance = .dark
        
        // Cusomize the toolbar
        //
        keys.toolbar.barTintColor = .brown
        
        // KMKeyBarButtonItemType.flexibleSpace, .cancel, .done
        // Mostly normal buttons, except can set custom titles
        //
        let flexibleSpace = KMKeyBarButtonItem(title: nil, style: UIBarButtonItemStyle.plain, action: KMKeyBarButtonItemType.flexibleSpace, kmKeys: keys)
        let cancelBarButton = KMKeyBarButtonItem(title: "Never Mind", style: .plain, action: .cancel, kmKeys: keys)
        let doneBarButton = KMKeyBarButtonItem(title: "Fire!!!", style: .done, action: .done, kmKeys: keys)
        
        // KMKeyBarButtonItemType.textInput
        // When you want a toolbar button's title to append to the textField
        //
        let plusButton = KMKeyBarButtonItem(title: "+", style: UIBarButtonItemStyle.plain, action: KMKeyBarButtonItemType.textInput, kmKeys: keys)
        let minusButton = KMKeyBarButtonItem(title: "-", style: .plain, action: .textInput, kmKeys: keys)
        let commaButton = KMKeyBarButtonItem(title: ",", style: .plain, action: .textInput, kmKeys: keys)
        
        // KMKeyBarButtonItemType.action
        // When you want a button to do
        let actionBarButton = KMKeyBarButtonItem(title: "Custom Action", style: .plain, action: KMKeyBarButtonItemType.action, kmKeys: keys, actionHandler: { (_ kmKeys:KMKeys?) in
            print("customAction")
            if let keys = kmKeys {
                keys.textField.text = "KMKeys!!!!"
            }
        })
        
        let fixedSpace = KMKeyBarButtonItem.fixedSpace()
        keys.setToolbarItems(items: [fixedSpace, cancelBarButton, flexibleSpace, plusButton, commaButton, minusButton, actionBarButton, flexibleSpace, doneBarButton, fixedSpace])
        keys.setToolbarItemsTintColor(color: .white)
        
        keys.show() { (text:String?) in
            self.label.text = text
        }
    }
}
