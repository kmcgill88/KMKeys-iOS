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
        keys.textField.backgroundColor = .brown
        keys.textField.textColor = .white
        keys.textField.keyboardType = .decimalPad
        keys.textField.keyboardAppearance = .dark
        
        keys.toolbar.tintColor = .brown
        keys.doneBarButton.tintColor = .white
        keys.cancelBarButton.tintColor = .white

        keys.setToolbarItems(items: [])
        
        keys.show() { (text:String?) in
            print(text ?? "No text here!!")
        }
    }
}
