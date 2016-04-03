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
    
    init(title: String){
        self.title = title
        
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
