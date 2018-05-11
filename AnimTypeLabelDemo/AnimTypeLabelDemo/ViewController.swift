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
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        label.setAnimatedText(text: "Privet chelovechestvo")
    }
}

