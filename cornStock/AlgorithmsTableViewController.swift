//
//  AlgorithmsTableViewController.swift
//  stockTalk
//
//  Created by jared weinstein on 4/1/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import Foundation
import UIKit

class AlgorithmsTableViewController: UITableViewController {
    //var algorithms = [Algorithm]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.init(red: 13/255, green: 13/255, blue: 13/255, alpha: 1)
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorColor = UIColor.grayColor()
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(self.add))
        
        //algorithms = Model.sharedInstance.algorithms
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func add(){
        let storyboard : UIStoryboard = UIStoryboard(name: "Add", bundle: nil)
        let addVC = storyboard.instantiateViewControllerWithIdentifier("addAlgorithm") as! AddViewController
        addVC.parent = self
        self.navigationController!.pushViewController(addVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.sharedInstance.algorithms.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "algorithmCell")
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel!.text = Model.sharedInstance.algorithms[indexPath.row].title
        cell.textLabel!.textColor = UIColor.whiteColor()
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //NSLog("NSIndexPath")
        let storyboard : UIStoryboard = UIStoryboard(name: "Algorithm", bundle: nil)
        let singleAlgorithmVC = storyboard.instantiateViewControllerWithIdentifier("singleAlgorithm") as! AlgorithmViewController
        singleAlgorithmVC.algorithm = Model.sharedInstance.algorithms[indexPath.row]
        self.navigationController!.pushViewController(singleAlgorithmVC, animated: true)
    }
    
    //Customize the Cell
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true;
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            // remove the deleted item from the model
            Model.sharedInstance.algorithms.removeAtIndex(indexPath.row)
            
            // remove the deleted item from the `UITableView`
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default:
            return
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        NSLog("SEGUE")
        let dest = segue.destinationViewController as! AddViewController
        dest.parent = self
    }
}


