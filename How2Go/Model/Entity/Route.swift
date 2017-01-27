//
//  Route.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/27/17.
//  Copyright © 2017 How2Go. All rights reserved.
//
/// Model class for Route object
import Foundation
public struct Route {
   
    // Properties
    var type: RouteType = .none
    var provider: String = ""
    var properties: Properties? = nil
    var segments: [Segment] = []
    var price: Price = Price()
   
    // MARK- Static methods
    static func createObject(fromData data: NSDictionary)-> [Route] {
        
        let values = data.value(forKey: "routes") as! [NSDictionary]
        var routesArray: [Route] = []
        for route in values {
            routesArray.append(Route.createObject(fromData: (route)))
        }
        return routesArray
    }
    
    static func createObject(fromData data: NSDictionary)-> Route {
        
        var route = Route()
        route.type = parseRouteType(type: data.value(forKey: "type") as! String)
        route.provider = data.value(forKey: "provider") as! String
        if let propertiesData = data.value(forKey: "properties") as? NSDictionary {
            route.properties = Properties.createObject(fromData: propertiesData, ofType: route.type)
        }
        
        if let priceData = data.value(forKey: "price") as? NSDictionary {            
            route.price = Price.createObject(fromData: priceData)
        }
        
        
        let segments = data.value(forKey: "segments") as! [NSDictionary]
        for segment in segments {
            route.segments.append(Segment.createObject(fromData: segment))
        }
        
        return route
        
    }
    
    // MARK:- Public structs
    public struct Price {
        var currency: String = "EUR"
        var amount: Float = 0.0
        
        static func createObject(fromData data: NSDictionary)-> Price {
            
            var price = Price()
            price.currency = data.value(forKey: "currency") as! String
            price.amount = data.value(forKey: "amount") as! Float
            
            return price
            
        }
        
        func getFormatValue()-> String {
            return String(format: "%0.2f €", self.amount)
        }
    }
}

// MARK:- Private helpers
fileprivate func parseRouteType(type: String)-> RouteType {
    switch type {
    case "public_transport":
        return .public_transport
    case "car_sharing":
        return .car_sharing
    case "private_bike":
        return .private_bike
    case "bike_sharing":
        return .bike_sharing
    case "taxi":
        return .taxi
    default:
        return .none
    }
}