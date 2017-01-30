//
//  APIClient.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/27/17.
//  Copyright © 2017 How2Go. All rights reserved.
//
/// This class is responsible for contacting server and retrive responses.
import Foundation
import Alamofire

class APIClient {
    /**
     Send request to server and retrive response.
     
     - parameter completion: The completion block, send either the reponse as NSDictionary object or nil in case or error.
     
     - returns: NSDictionary as response or error.
     */
   open func getRoutes(_ completion: @escaping Completion) {
        Alamofire.request(serverURL).responseJSON { response in

            if let JSON = response.result.value {
                completion( Route.createObject(fromData: (JSON as! NSDictionary)), nil)
            } else {
                completion(nil, response.error)
            }
        }
    }
}
