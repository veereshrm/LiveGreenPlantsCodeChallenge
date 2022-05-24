//
//  LGPTextViewAddition.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 23/05/22.
//


import UIKit

extension UITextView {

    /**
     - Function   used to done button when keyboard appears.
     */
    func addKeyboardToolBar(){
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = .white
        toolBar.backgroundColor = .white
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action:#selector(self.done))
        doneButton.tintColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.inputAccessoryView = toolBar
    }

    @objc func done() {
       self.resignFirstResponder()
    }

    @objc func cancel() {
        self.resignFirstResponder()
    }
}
