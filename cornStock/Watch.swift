//
//  File.swift
//  stockTalk
//
//  Created by jared weinstein on 4/2/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import Foundation

class Watch : NSObject{
    var ticker : String!
    var algorithm : Algorithm!
    
    init(ticker: String, algorithm: Algorithm){
        self.ticker = ticker
        self.algorithm = algorithm
    }
}
