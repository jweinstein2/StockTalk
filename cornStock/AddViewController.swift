//
//  AddViewController.swift
//  stockTalk
//
//  Created by jared weinstein on 4/2/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import Foundation
import UIKit

class AddViewController: UIViewController{
    var parent : AlgorithmsTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Algorithm"
        // Do any additional setup after loading the view, typically from a nib.
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
        if(true){
            //Need to add the algorithm to the list of algorithms
            let created = Algorithm.init(title: "newly created")
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

