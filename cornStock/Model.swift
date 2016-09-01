//
//  Model.swift
//  stockTalk
//
//  Created by jared weinstein on 4/1/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import Foundation
import UIKit

class Model : NSObject{
    var watchlist = [Watch]()
    var algorithms = [Algorithm]()
    var downloader = DataDownloader()
    var defaultTicker = "GOOG"
    
    //Singleton Init
    class var sharedInstance : Model {
        struct Static {
            static let instance : Model = Model()
        }
        return Static.instance
    }
    
    func setup(){
        //Test setup script to cheat the web API connection
        NSLog("running setup")
        algorithms.append(Algorithm.init(title: "kd"))
        algorithms.append(Algorithm.init(title: "rando"))
        algorithms.append(Algorithm.init(title: "dchange"))
        algorithms.append(Algorithm.init(title: "dchange10"))
        algorithms.append(Algorithm.init(title: "dchange1"))
        watchlist.append(Watch.init(ticker: "AMD", algorithm: algorithms[0]))
        watchlist.append(Watch.init(ticker: "AMD", algorithm: algorithms[4]))
        watchlist.append(Watch.init(ticker: "CPRX", algorithm: algorithms[4]))
        watchlist.append(Watch.init(ticker: "MRNS", algorithm: algorithms[1]))
        watchlist.append(Watch.init(ticker: "AAPL", algorithm: algorithms[2]))
        watchlist.append(Watch.init(ticker: "GOOG", algorithm: algorithms[3]))
        //downloader.downloadJSON("https://stocktrak.herokuapp.com/test", notification: "Algorithm 1")
        //downloader.downloadJSON("https://stocktrak.herokuapp.com/test", notification: "Algorithm 2")
        //downloader.downloadJSON("https://stocktrak.herokuapp.com/test", notification: "Algorithm 3")
        //downloader.downloadJSON("https://stocktrak.herokuapp.com/test", notification: "Algorithm 4")
    }
}
