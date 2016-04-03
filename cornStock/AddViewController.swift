//
//  AddViewController.swift
//  stockTalk
//
//  Created by jared weinstein on 4/2/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import Foundation
import UIKit

class AddViewController: UIViewController, UITextFieldDelegate{
    var parent : AlgorithmsTableViewController!
    var tit : String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Algorithm"
        let backgroundTap = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
        backgroundTap.numberOfTapsRequired = 1;
        self.view.addGestureRecognizer(backgroundTap)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func edit(sender: UITextField) {
        tit = sender.text
    }
    
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addParameter(sender: AnyObject) {
        NSLog("Add Parameter")
    }
    
    @IBAction func submit(sender: AnyObject) {
        NSLog("Submit")
        if(tit != ""){
            //Need to add the algorithm to the list of algorithms
            let created = Algorithm.init(title: self.tit)
            Model.sharedInstance.algorithms.append(created)
            self.parent.tableView.reloadData()
            self.navigationController!.popViewControllerAnimated(true)
        }else{
            let alert = UIAlertController(title: "Unable to Create", message: "Need valid parameters to create Algorithm", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}

