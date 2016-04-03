//
//  AlgorithmViewController.swift
//  Algorithms
//
//  Created by jared weinstein on 1/4/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import UIKit
import Foundation

class AlgorithmViewController: UIViewController, BEMSimpleLineGraphDelegate, BEMSimpleLineGraphDataSource{
    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var timeFrame: UISegmentedControl!
    @IBOutlet weak var earnings: BEMSimpleLineGraphView!
    @IBOutlet weak var myGraph: BEMSimpleLineGraphView!
    
    var algorithm : Algorithm!
    var kNotification : String!
    var price : NSMutableArray = NSMutableArray.init(capacity: 250)
    var profit : NSMutableArray = NSMutableArray.init(capacity: 250)
    var isLoaded = false
    var timeFrameState = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tickerLabel.text = Model.sharedInstance.defaultTicker
        kNotification = algorithm.title
        Model.sharedInstance.downloader.downloadJSON("https://stocktalk-dduan97.c9users.io/t/" + Model.sharedInstance.defaultTicker + "/a/" + algorithm.title, notification: kNotification)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.dataUpdated(_:)), name: kNotification, object: nil)
        
        myGraph.delegate = self
        myGraph.dataSource = self
        earnings.delegate = self
        earnings.dataSource = self
        self.title = algorithm.title
    }
    
    @IBAction func timeChanged(sender: UISegmentedControl) {
        timeFrameState = sender.selectedSegmentIndex
        myGraph.reloadGraph()
        earnings.reloadGraph()
    }
    
    func dataUpdated(notification: NSNotification){
        let values = notification.userInfo! as NSDictionary
        let dict = values.objectForKey(algorithm.title) as! NSDictionary
        let series = dict.objectForKey("series") as! NSArray
        for entry in series{
            let entryDict : NSDictionary = entry as! NSDictionary
            let value = (entryDict.objectForKey("price"))! as! Double
            let earnings = (entryDict.objectForKey("profit"))! as! Double
            self.profit.addObject(earnings)
            self.price.addObject(value)
        }
        
        isLoaded = true;
        myGraph.reloadGraph()
        earnings.reloadGraph()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        if(isLoaded){
            if(graph == myGraph){
                switch timeFrameState {
                case 0:
                    return self.price.count
                case 1:
                    return self.price.count / 2
                case 2:
                    return self.price.count / 4
                default:
                    NSLog("error")
                }
            }else if(graph == earnings){
                switch timeFrameState {
                case 0:
                    return self.profit.count
                case 1:
                    return self.profit.count / 2
                case 2:
                    return self.profit.count / 4
                default:
                    NSLog("error")
                }
            }else{
                NSLog("error")
            }
        }
        return 5;
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, valueForPointAtIndex index: Int) -> CGFloat {
        if(isLoaded){
            if(graph == myGraph){
                return self.price.objectAtIndex(index) as! CGFloat
            }else if(graph == earnings){
                return self.profit.objectAtIndex(index) as! CGFloat
            }else{
                NSLog("error")
            }
        }
        return 5;
    }
}
