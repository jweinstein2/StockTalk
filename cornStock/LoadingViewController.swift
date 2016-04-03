//
//  LoadingViewController.swift
//  stockTalk
//
//  Created by jared weinstein on 4/2/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import UIKit
import Foundation

class LoadingViewController: UIViewController {
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueButton.hidden = true;
        Model.sharedInstance.setup()
        self.checkLoaded()
    }
    
    func checkLoaded(){
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(3 * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), {
                self.loaded()
            }
        )
    }
    
    func loaded(){
        continueButton.hidden = false;
    }
}
