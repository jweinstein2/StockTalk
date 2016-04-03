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
    @IBOutlet weak var eLabel3: UIButton!
    @IBOutlet weak var eLabel2: UIButton!
    @IBOutlet weak var eLabel1: UIButton!
    @IBOutlet weak var profitLabel: UIButton!
    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var timeFrame: UISegmentedControl!
    @IBOutlet weak var earnings: BEMSimpleLineGraphView!
    @IBOutlet weak var myGraph: BEMSimpleLineGraphView!
    var isWaiting = false
    
    var algorithm : Algorithm!
    
    var timeFrameState = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(!algorithm.needsReload){
            switch timeFrameState {
            case 0:
                profitLabel.setTitle(String.init(format: "$%.4f", algorithm.profit[algorithm.profit.count - 1] as! Double), forState: .Normal)
                break
            case 1:
                profitLabel.setTitle(String.init(format: "$%.4f", algorithm.profit[algorithm.profit.count / 2 - 1] as! Double), forState: .Normal)
                break
            case 2:
                profitLabel.setTitle(String.init(format: "$%.4f", algorithm.profit[algorithm.profit.count / 4 - 1] as! Double), forState: .Normal)
                break
            default:
                NSLog("error")
            }
            eLabel1.setTitle(String.init(format: "%.4f", algorithm.e1), forState: .Normal)
            eLabel2.setTitle(String.init(format: "%.4f", algorithm.e2), forState: .Normal)
            eLabel3.setTitle(String.init(format: "%.4f", algorithm.e3), forState: .Normal)
            
            tickerLabel.text = Model.sharedInstance.defaultTicker
            
            myGraph.delegate = self
            myGraph.dataSource = self
            earnings.delegate = self
            earnings.dataSource = self
            self.title = algorithm.title
        }else{
            self.isWaiting = true
            NSLog("reload")
            algorithm.needsReload = true
            algorithm.isLoaded = false;
            algorithm.reload()
            dispatch_after(
                dispatch_time(
                    DISPATCH_TIME_NOW,
                    Int64(3 * Double(NSEC_PER_SEC))
                ),
                dispatch_get_main_queue(), {
                    self.algorithm.isLoaded = true
                    self.myGraph.reloadGraph()
                    self.earnings.reloadGraph()
                    self.isWaiting = false
                }
            )
        }
    }
    
    @IBAction func timeChanged(sender: UISegmentedControl) {
        timeFrameState = sender.selectedSegmentIndex
        switch timeFrameState {
        case 0:
            profitLabel.setTitle(String.init(format: "$%.4f", algorithm.profit[algorithm.profit.count - 1] as! Double), forState: .Normal)
            break
        case 1:
            profitLabel.setTitle(String.init(format: "$%.4f", algorithm.profit[algorithm.profit.count / 2 - 1] as! Double), forState: .Normal)
            break
        case 2:
            profitLabel.setTitle(String.init(format: "$%.4f", algorithm.profit[algorithm.profit.count / 4 - 1] as! Double), forState: .Normal)
            break
        default:
            NSLog("error")
        }
        myGraph.reloadGraph()
        earnings.reloadGraph()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        NSLog("TESTING *** : " + String(isWaiting))
        if(algorithm.isLoaded && !isWaiting){
            if(graph == myGraph){
                if(self.algorithm.price.count == 0){
                    return 5
                }
                switch timeFrameState {
                case 0:
                    return self.algorithm.price.count
                case 1:
                    return self.algorithm.price.count / 2
                case 2:
                    return self.algorithm.price.count / 4
                default:
                    NSLog("error")
                }
            }else if(graph == earnings){
                if(self.algorithm.profit.count == 0){
                    return 5
                }
                switch timeFrameState {
                case 0:
                    return self.algorithm.profit.count
                case 1:
                    return self.algorithm.profit.count / 2
                case 2:
                    return self.algorithm.profit.count / 4
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
        NSLog("TESTING *** : " + String(isWaiting))
        if(algorithm.isLoaded && !isWaiting){
            if(graph == myGraph){
                if(self.algorithm.price.count == 0){
                    return 5
                }
                return self.algorithm.price.objectAtIndex(index) as! CGFloat
            }else if(graph == earnings){
                if(self.algorithm.profit.count == 0){
                    return 5
                }
                return self.algorithm.profit.objectAtIndex(index) as! CGFloat
            }else{
                NSLog("error")
            }
        }
        return 5;
    }
}
