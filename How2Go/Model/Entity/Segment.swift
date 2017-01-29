//
//  Segment.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/27/17.
//  Copyright © 2017 How2Go. All rights reserved.
//
/// Model class for Segment Object
import Foundation

enum TravelMode: String {
    case unknown = "--"
    case walking = "Walking"
    case subway = "Subway"
    case bus = "Bus"
    case change = "Change"
    case setup = "Setup"
    case driving = "Driving"
    case parking = "Parking"
    case cycling = "Cyclying"
}
struct Segment {
    
    // Properties
    var name: String? = nil
    var numberOfStops: Int = 0
    var travelMode: TravelMode = .walking
    var description: String? = nil
    var color: String = ""
    var iconUrl: String = ""
    var polyline: String? = nil
    var stops: [Stop] = []
    var isExpanded: Bool = false
    var totalTime: Float = 0.0
    
    static internal var dateFormatter: DateFormatter = DateFormatter()
    
    // MARK:- Static methods
    static func createObject(fromData data: NSDictionary)-> Segment {
        
        var segment = Segment()
        segment.name = data.value(forKey: "name") as? String        
        segment.travelMode = parseTravelMode(string: data.value(forKey: "travel_mode") as! String)
        segment.description = data.value(forKey: "description") as? String
        segment.color = data.value(forKey: "color") as! String
        segment.iconUrl = data.value(forKey: "icon_url") as! String
        segment.polyline = data.value(forKey: "polyline") as? String
        
        let stops = data.value(forKey: "stops") as! [NSDictionary]
        for stop in stops {
            segment.stops.append(Stop.createObject(fromData: stop))
        }
        segment.numberOfStops = segment.stops.count
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        if let firstStopDate = dateFormatter.date(from: segment.stops[0].dateTime), let lastStopDate = dateFormatter.date(from: segment.stops[segment.stops.count - 1].dateTime){
            segment.totalTime = Float(lastStopDate.timeIntervalSince(firstStopDate)) / 60.0;            
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
