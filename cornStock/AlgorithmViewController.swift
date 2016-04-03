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
    
    var timeFrameState = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tickerLabel.text = Model.sharedInstance.defaultTicker
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        if(algorithm.isLoaded){
            if(graph == myGraph){
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
        if(algorithm.isLoaded){
            if(graph == myGraph){
                return self.algorithm.price.objectAtIndex(index) as! CGFloat
            }else if(graph == earnings){
                return self.algorithm.profit.objectAtIndex(index) as! CGFloat
            }else{
                NSLog("error")
            }
        }
        return 5;
    }
}
