//
//  Provider.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/27/17.
//  Copyright © 2017 How2Go. All rights reserved.
//
/// Model class for Provider object
import Foundation
public struct Provider {
    
    // Properties
    var providerIconUrl: String? = nil
    var disclaimer: String? = nil
    var displayName: String? = nil
    var itunesUrl: String? = nil
    
    static func createObject(fromData data: NSDictionary)-> [Provider] {

        let values = data.value(forKey: "provider_attributes") as! [NSDictionary]
        
        var providersArray: [Provider] = []
        for provider in values {
            providersArray.append(Provider.createObject(fromData: (provider)))
        }
        return providersArray
        
        
    }
    
    static func createObject(fromData data: NSDictionary)-> Provider {
        
        var provider = Provider()
        provider.providerIconUrl = data.value(forKey: "provider_icon_url") as? String
        provider.disclaimer = data.value(forKey: "disclaimer") as? String
        provider.displayName = data.value(forKey: "display_name") as? String
        provider.itunesUrl = data.value(forKey: "ios_itunes_url") as? String
        
        return provider
    }
}
