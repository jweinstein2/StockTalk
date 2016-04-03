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
    var kNotification : String!
    var price : NSMutableArray = NSMutableArray.init(capacity: 250)
    var profit : NSMutableArray = NSMutableArray.init(capacity: 250)
    var isLoaded = false
    
    init(title: String){
        super.init()
        self.title = title
        
        kNotification = self.title
        Model.sharedInstance.downloader.downloadJSON("https://stocktalk-dduan97.c9users.io/t/" + Model.sharedInstance.defaultTicker + "/a/" + self.title, notification: kNotification)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.dataUpdated(_:)), name: kNotification, object: nil)
    }
    
    func dataUpdated(notification: NSNotification){
        let values = notification.userInfo! as NSDictionary
        let dict = values.objectForKey(self.title) as! NSDictionary
        let series = dict.objectForKey("series") as! NSArray
        for entry in series{
            let entryDict : NSDictionary = entry as! NSDictionary
            let value = (entryDict.objectForKey("price"))! as! Double
            let earnings = (entryDict.objectForKey("profit"))! as! Double
            self.profit.addObject(earnings)
            self.price.addObject(value)
        }
        
        isLoaded = true;
    }
    
    func isHoldPeriod() -> Bool{
        return true;
    }
    
    func shouldBuy() -> Bool {
        return true;
    }
    
    func shouldSell() -> Bool {
        return false;
    }
}
