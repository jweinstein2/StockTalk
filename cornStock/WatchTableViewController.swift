//
//  File.swift
//  stockTalk
//
//  Created by jared weinstein on 4/2/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import Foundation
import UIKit

class WatchTableViewController: UITableViewController{
    var watchlist = [Watch]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.init(red: 13/255, green: 13/255, blue: 13/255, alpha: 1)
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor.grayColor()
        watchlist = Model.sharedInstance.watchlist
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func add(){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.sharedInstance.watchlist.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "watchCell")
        cell.textLabel!.text = Model.sharedInstance.watchlist[indexPath.row].ticker + " | " + Model.sharedInstance.watchlist[indexPath.row].algorithm.title
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel!.textColor = UIColor.whiteColor()
        cell.textLabel!.font = UIFont.init(name: "Avenir Bold", size: 14)
        cell.detailTextLabel!.font = UIFont.init(name: "Avenir", size: 14)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Currently the cells are unselectable
        //NSLog("NSIndexPath")
        /*
        let storyboard : UIStoryboard = UIStoryboard(name: "Algorithm", bundle: nil)
        let singleAlgorithmVC = storyboard.instantiateViewControllerWithIdentifier("singleAlgorithm") as! AlgorithmViewController
        singleAlgorithmVC.algorithm = algorithms[indexPath.row]
        self.navigationController!.pushViewController(singleAlgorithmVC, animated: true)
        */
    }
    
    //Customize the Cell
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if(Model.sharedInstance.watchlist[indexPath.row].algorithm.isHoldPeriod()){
            cell.textLabel!.textColor = UIColor.redColor()
        }else{
            cell.textLabel!.textColor = UIColor.greenColor()
        }
        if(Model.sharedInstance.watchlist[indexPath.row].algorithm.shouldBuy()){
            cell.detailTextLabel!.text = "buy"
        }
        if(Model.sharedInstance.watchlist[indexPath.row].algorithm.shouldSell()){
            cell.detailTextLabel!.text = "sell"
        }
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
            Model.sharedInstance.watchlist.removeAtIndex(indexPath.row)
            
            // remove the deleted item from the `UITableView`
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default:
            return
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        NSLog("SEGUE")
        if(segue.identifier == "tableToAdd"){
            let dest = segue.destinationViewController as! AddWatchViewController
            dest.parent = self
        }
    }
}