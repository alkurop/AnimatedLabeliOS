//
//  ViewController.swift
//  AnimTypeLabelDemo
//
//  Created by Alexey Kuropiantnyk on 11/05/2018.
//  Copyright © 2018 Alexey Kuropiantnyk. All rights reserved.
//

import UIKit
import AnimDelayLabel

class ViewController : UIViewController {
    @IBOutlet weak var label: AnimTypeLabel!
    @IBOutlet weak var textField: AnimTypeTextField!
    @IBOutlet weak var textView: AnimTypeTextView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        label.setAnimatedText(text: "Privet chelovechestvo")
        textField.setAnimatedText(text:"Privet chelovechestvo")
        textView.setAnimatedText(text: text)
    }
}

let text = """
Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.
"""
