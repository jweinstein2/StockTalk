//
//  AddWatchViewController.swift
//  stockTalk
//
//  Created by jared weinstein on 4/2/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import Foundation
import UIKit

class AddWatchViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    @IBOutlet weak var tickerField: UITextField!
    var ticker = "AAPL"
    @IBOutlet weak var algorithmView: UITableView!
    var parent : WatchTableViewController!
    var backgroundTap : UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundTap = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
        backgroundTap.numberOfTapsRequired = 1;
        
        
        algorithmView.tableFooterView = UIView()
        algorithmView.separatorColor = UIColor.darkGrayColor()
        algorithmView.delegate = self;
        algorithmView.dataSource = self;
        tickerField.delegate = self;
        tickerField.placeholder = Model.sharedInstance.defaultTicker
        algorithmView.backgroundColor = UIColor.init(red: 13/255, green: 13/255, blue: 13/255, alpha: 1)
    }
    
    @IBAction func editingDidBegin(sender: AnyObject) {
        self.view.addGestureRecognizer(backgroundTap)
    }
    
    @IBAction func tickerEdited(sender: UITextField) {
        ticker = sender.text!
    }

    @IBAction func submit(sender: AnyObject) {
        NSLog(String(algorithmView.indexPathForSelectedRow))
        if(algorithmView.indexPathForSelectedRow == nil){
            let alert = UIAlertController(title: "Please Select an Algorithm", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            let new = Watch.init(ticker: ticker, algorithm: Model.sharedInstance.algorithms[algorithmView.indexPathForSelectedRow!.row])
            Model.sharedInstance.watchlist.append(new)
            NSLog(String(Model.sharedInstance.watchlist))
            //let newIndexPath = NSIndexPath(forRow: Model.sharedInstance.watchlist.count, inSection: 0)
            //self.parent.tableView.([newIndexPath], withRowAnimation: .Bottom)
            self.parent.tableView.reloadData()
            self.navigationController!.popViewControllerAnimated(true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.sharedInstance.algorithms.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "algorithmCell")
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel!.text = Model.sharedInstance.algorithms[indexPath.row].title
        cell.textLabel!.textColor = UIColor.whiteColor()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    //Customize the Cell
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true;
    }
    
    func dismissKeyboard(){
        self.view.endEditing(true)
        self.resignFirstResponder()
        self.view.addGestureRecognizer(backgroundTap)
        self.view.removeGestureRecognizer(backgroundTap)
    }
}
