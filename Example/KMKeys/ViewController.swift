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
        keys.textField.font = UIFont(name: "American Typewriter", size: 16.0)!
        keys.textField.placeholderColor = UIColor.init(white: 255/255, alpha: 0.75)
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
//        let cancelBarButton = KMKeyBarButtonItem.cancel() //<-- Shortcut helper, if custom name not needed

        let doneBarButton = KMKeyBarButtonItem.done() //<-- Shortcut helper, if custom name not needed
//        let doneBarButton = KMKeyBarButtonItem(title: "Fire!!!", style: .done, action: .done, kmKeys: keys)

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
        keys.setToolbarItemsFont(font: UIFont(name: "American Typewriter", size: 16.0)!)
        
        keys.show() { (text:String?) in
            self.label.text = text
        }
    }
}
