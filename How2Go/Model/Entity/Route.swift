//
//  Route.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/27/17.
//  Copyright © 2017 How2Go. All rights reserved.
//

import Foundation
public struct Route {
   
    var type: String = ""
    var provider: String = ""
    var properties: String? = nil
    var segments: [Segment] = []
    var price: Price = Price()
   
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
        route.type = data.value(forKey: "type") as! String
        route.provider = data.value(forKey: "provider") as! String
        route.properties = data.value(forKey: "properties") as? String
        if let priceData = data.value(forKey: "price") as? NSDictionary {            
            route.price = Price.createObject(fromData: priceData)
        }
        
        
        let segments = data.value(forKey: "segments") as! [NSDictionary]
        for segment in segments {
            route.segments.append(Segment.createObject(fromData: segment))
        }
        
        return route
        
    }
    
    public struct Price {
        var currency: String = "EUR"
        var amount: Float = 0.0
        
        static func createObject(fromData data: NSDictionary)-> Price {
            
            var price = Price()
            price.currency = data.value(forKey: "currency") as! String
            price.amount = data.value(forKey: "amount") as! Float
            
            return price
            
        }
    }
}
