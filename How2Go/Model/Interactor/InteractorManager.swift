//
//  InteractorManager.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/27/17.
//  Copyright © 2017 How2Go. All rights reserved.
//
/// InteractorManager is in charge of interact with model layer and parse the response
import Foundation
class InteractorManager {
    
    let apiClient: APIClient!
    
    static let sharedInstance : InteractorManager = {
        let instance = InteractorManager()
        return instance
    }()
    
    init() {
        apiClient = APIClient()
    }
    
    func getRoutesData(_ completion: @escaping completion) {
        
        apiClient.getRoutes { (routesArr, error) in
            if error != nil {
                //Call UIdelegate error emthod
                completion(nil, error)
                return
            }
//            let routesArray = Route.createObject(fromData: routesArr)
        }
    }
    
}
