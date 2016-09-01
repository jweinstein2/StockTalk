//
//  Algorithm.swift
//  stockTalk
//
//  Created by jared weinstein on 4/1/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import Foundation

class Algorithm : NSObject{
    var title : String!
    var needsReload : Bool!
    var descript : String!
    var kNotification : String!
    var price : NSMutableArray = NSMutableArray.init(capacity: 250)
    var profit : NSMutableArray = NSMutableArray.init(capacity: 250)
    var isLoaded = false
    var hp : Bool!
    var b : Bool!
    var s : Bool!
    var e1 : Double!
    var e2 : Double!
    var e3 : Double!
    
    init(title: String){
        super.init()
        self.title = title
        needsReload = false
        kNotification = self.title
        Model.sharedInstance.downloader.downloadJSON("https://stocktrak.herokuapp.com/t/" + Model.sharedInstance.defaultTicker + "/a/" + self.title, notification: kNotification)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.dataUpdated(_:)), name: kNotification, object: nil)
    }
    
    func dataUpdated(notification: NSNotification){
        let values = notification.userInfo! as NSDictionary
        NSLog(String(values))
        let dict = values.objectForKey(self.title) as! NSDictionary
        descript = String(dict.objectForKey("descript")!)
        //NSLog(String(dict.objectForKey("currentHold")!))
        //NSLog(String(dict.objectForKey("currentBuy")!))
        NSLog(String(dict.objectForKey("currentSell")!))
        if(String(dict.objectForKey("currentHold")!) == "1"){
            hp = true
        }else{
            hp = false
        }
        if(String(dict.objectForKey("currentBuy")!) == "1"){
            b = true
        }else{
            b = false
        }
        if(String(dict.objectForKey("currentSell")!) == "1"){
            s = true
        }else{
            s = false
        }
        var profitTemp : NSMutableArray = NSMutableArray.init(capacity: 250)
        var priceTemp : NSMutableArray = NSMutableArray.init(capacity: 250)
        e1 = dict.objectForKey("efficiency")! as! Double
        e2 = dict.objectForKey("simpleEfficiency")! as! Double
        e3 = dict.objectForKey("randomEfficiency")! as! Double
        let series = dict.objectForKey("series") as! NSArray
        for entry in series{
            let entryDict : NSDictionary = entry as! NSDictionary
            let value = (entryDict.objectForKey("price"))! as! Double
            let earnings = (entryDict.objectForKey("profit"))! as! Double
            profitTemp.addObject(earnings)
            priceTemp.addObject(value)
        }
        
        self.profit = profitTemp
        self.price = priceTemp
        isLoaded = true
        needsReload = false
    }
    
    func isHoldPeriod() -> Bool{
        return hp
    }
    
    func shouldBuy() -> Bool {
        return b
    }
    
    func shouldSell() -> Bool {
        return s
    }
    
    func reload(){
        self.isLoaded = false
        kNotification = self.title
        Model.sharedInstance.downloader.downloadJSON("https://stocktrak.herokuapp.com/t/" + Model.sharedInstance.defaultTicker + "/a/" + self.title, notification: kNotification)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.dataUpdated(_:)), name: kNotification, object: nil)
    }
}
