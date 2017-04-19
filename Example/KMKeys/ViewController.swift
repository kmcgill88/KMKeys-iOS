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
        
        let doneBarButton = KMKeyBarButtonItem(title: "done", style: UIBarButtonItemStyle.done, action: KMKeyBarButtonItemAction.done, kmKeys: keys)
        let cancelBarButton = KMKeyBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(KMKeys.cancel))
        let flexibleSpace = KMKeyBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        keys.doneBarButton.tintColor = .white
//        keys.cancelBarButton.tintColor = .white

        
        
        keys.show() { (text:String?) in
            print(text ?? "No text here!!")
        }
    }
}
