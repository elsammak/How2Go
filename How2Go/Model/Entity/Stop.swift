//
//  Stop.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/27/17.
//  Copyright © 2017 How2Go. All rights reserved.
//

import Foundation
struct Stop {
    
    var lat: Double = 0.0
    var lon: Double = 0.0
    var dateTime: String = ""
    var name: String? = nil
    var properties: String? = nil
    
    static func createObject(fromData data: NSDictionary)-> Stop {
        
        var stop = Stop()
        stop.lat = data.value(forKey: "lat") as! Double
        stop.lon = data.value(forKey: "lng") as! Double
        stop.dateTime = data.value(forKey: "datetime") as! String
        stop.name = data.value(forKey: "name") as? String
        stop.properties = data.value(forKey: "properties") as? String
        return stop
    }
}
