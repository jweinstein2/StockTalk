//
//  Parameter.swift
//  stockTalk
//
//  Created by jared weinstein on 4/2/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import Foundation

class Parameter : NSObject{
    var isAnd : Bool
    var variable : String
    var lowerBound : Float
    var upperBound : Float

    init(and: Bool, variable: String, lowerBound : Float, upperBound: Float){
        self.isAnd = and
        self.variable = variable
        self.lowerBound = lowerBound
        self.upperBound = upperBound
    }
}
