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


    @IBAction func pressed(_ sender: UIButton) {
        
        let keys = KMKeys()
        keys.textField.textAlignment = .center
        keys.textField.placeholder = "Placeholder Text Here"
        keys.textField.backgroundColor = .brown
        keys.textField.textColor = .white
        keys.textField.tintColor = .white
        keys.textField.keyboardType = .decimalPad
        keys.textField.keyboardAppearance = .dark
        
        keys.toolbar.barTintColor = .brown
        
        
        let flexibleSpace = KMKeyBarButtonItem(title: nil,
                                               style: UIBarButtonItemStyle.plain,
                                               action: KMKeyBarButtonItemType.flexibleSpace,
                                               kmKeys: keys)
        
        let cancelBarButton = KMKeyBarButtonItem(title: "Cancel",
                                                 style: UIBarButtonItemStyle.plain,
                                                 action: KMKeyBarButtonItemType.cancel,
                                                 kmKeys: keys)
        
        let plusButton = KMKeyBarButtonItem(title: "+",
                                            style: UIBarButtonItemStyle.plain,
                                            action: KMKeyBarButtonItemType.customTextInput,
                                            kmKeys: keys)
        let minusButton = KMKeyBarButtonItem(title: "-",
                                             style: UIBarButtonItemStyle.plain,
                                             action: KMKeyBarButtonItemType.customTextInput,
                                             kmKeys: keys)
        
        let commaButton = KMKeyBarButtonItem(title: ",",
                                             style: UIBarButtonItemStyle.plain,
                                             action: KMKeyBarButtonItemType.customTextInput,
                                             kmKeys: keys)
        
        let doneBarButton = KMKeyBarButtonItem(title: "Done",
                                               style: UIBarButtonItemStyle.done,
                                               action: KMKeyBarButtonItemType.done,
                                               kmKeys: keys)

        keys.setToolbarItems(items: [cancelBarButton, flexibleSpace, plusButton, commaButton, minusButton, flexibleSpace, doneBarButton])
        keys.setToolbarItemsTintColor(color: .white)

        keys.show() { (text:String?) in
            print(text ?? "No text here!!")
        }
        
//        keys.show(completionHandler: { (text:String?) in
//            
//        })
    }
}
