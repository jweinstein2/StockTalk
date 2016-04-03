//
//  DataDownloader.swift
//  Spirax
//
//  Created by jared weinstein on 1/1/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import Foundation
import UIKit

class DataDownloader{
    func downloadJSON (urlString: String, notification: String){
        let url : NSURL = NSURL(string: urlString)!
        let request: NSURLRequest = NSURLRequest(URL:url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        //3: Completion block/Clousure for the NSURLSessionDataTask
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            if((error) != nil) {
                NSLog(error!.localizedDescription)
            }
            else {
                do {
                    let jsonDict = try (NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableDictionary)
                    //NSLog(String(jsonDict))
                    dispatch_async(dispatch_get_main_queue(), {
                        NSNotificationCenter.defaultCenter().postNotificationName(notification, object: nil, userInfo: [notification
                            :jsonDict])
                    })
                } catch let x {
                    NSLog("JSON Error" + String(x))     //NSLog("JSON Error \(err!.localizedDescription)")
                }
                //4: JSON process
            }
        })
        
        //6: DONT FORGET to LAUNCH the NSURLSessionDataTask!!!!!!
        task.resume()
    }
}
