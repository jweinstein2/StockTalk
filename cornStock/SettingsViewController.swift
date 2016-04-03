//
//  SettingsViewController.swift
//  stockTalk
//
//  Created by jared weinstein on 4/2/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundTap = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
        backgroundTap.numberOfTapsRequired = 1;
        self.view.addGestureRecognizer(backgroundTap)
    }
    
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    @IBAction func editingFinished(sender: UITextField) {
        if(Model.sharedInstance.defaultTicker != sender.text!){
            for algorithm in Model.sharedInstance.algorithms{
                algorithm.needsReload = true
            }
        }
        Model.sharedInstance.defaultTicker = sender.text!

    }
}

