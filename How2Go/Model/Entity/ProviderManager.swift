//
//  ProviderManager.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/27/17.
//  Copyright © 2017 How2Go. All rights reserved.
//

import Foundation
class ProviderManager {
    
    static let sharedInstance : ProviderManager = {
        let instance = ProviderManager()
        return instance
    }()
    
    var providersArray : [String : Provider] = [:]
    
    func parseProvidersResponse(fromData data: NSDictionary) {
        
        //Parsing providers array
        for provider in data {
          providersArray[provider.key as! String] = Provider.createObject(fromData: (provider.value as! NSDictionary))
        }
    }
    
    func getProvider(forProviderName name: String)-> Provider? {
        return providersArray[name]
    }
}