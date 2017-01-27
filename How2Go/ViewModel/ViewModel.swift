//
//  ViewModel.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/27/17.
//  Copyright © 2017 How2Go. All rights reserved.
//
///The viewModel layer, it interacts with model part and update the UI layer
import Foundation
class ViewModel {
    
    private let apiClient: APIClient!
    
    init() {
        apiClient = APIClient()
    }
    
    func getRouteData() {
        apiClient.getRoutes { (data, error) in
            if error != nil { // Error occured
                // Call UI error delegate method
                return
            }
            
            
        }
    }
}
