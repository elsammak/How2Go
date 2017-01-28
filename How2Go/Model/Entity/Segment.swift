//
//  Segment.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/27/17.
//  Copyright © 2017 How2Go. All rights reserved.
//
/// Model class for Segment Object
import Foundation

enum TravelMode: Int {
    case unknown
    case walking
    case subway
    case bus
    case change
    case setup
    case driving
    case parking
    case cycling    
}
struct Segment {
    
    // Properties
    var name: String? = nil
    var numberOfStops: Float = 0.0
    var travelMode: TravelMode = .walking
    var description: String? = nil
    var color: String = ""
    var iconUrl: String = ""
    var polyline: String? = nil
    var stops: [Stop] = []
    
    // MARK:- Static methods
    static func createObject(fromData data: NSDictionary)-> Segment {
        
        var segment = Segment()
        segment.name = data.value(forKey: "name") as? String
        segment.numberOfStops = data.value(forKey: "num_stops") as! Float
        segment.travelMode = parseTravelMode(string: data.value(forKey: "travel_mode") as! String)
        segment.description = data.value(forKey: "description") as? String
        segment.color = data.value(forKey: "color") as! String
        segment.iconUrl = data.value(forKey: "icon_url") as! String
        segment.polyline = data.value(forKey: "polyline") as? String
        
        let stops = data.value(forKey: "stops") as! [NSDictionary]
        for stop in stops {
            segment.stops.append(Stop.createObject(fromData: stop))
        }
        
        return segment
    }
    
}

// Private helpers
fileprivate func parseTravelMode(string: String)-> TravelMode {
    
    switch string {
    case "walking":
        return .walking
    case "subway":
        return .subway
    case "bus":
        return .bus
    case "change":
        return .change
    case "setup":
        return .setup
    case "driving":
        return .driving
    case "parking":
        return .parking
    case "cycling":
        return .cycling
    default:
        break
    }
    return .unknown
}
