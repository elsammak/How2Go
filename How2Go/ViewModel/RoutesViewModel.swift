//
//  RoutesViewModel.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/27/17.
//  Copyright © 2017 How2Go. All rights reserved.
//
///The viewModel layer, it interacts with model part and update the UI layer
import Foundation

protocol RoutesDelegate: class {
    func updateUIWithData(routes: [Route]?)
    func updateUIWithError(error: Error)
}
class RoutesViewModel {

    public weak var delegate: RoutesDelegate!
    private let apiClient: APIClient!

    // MARK: - Init
    init() {
        apiClient = APIClient()
    }

    // MARK: - API methods
    func getRouteData() {
        apiClient.getRoutes { [unowned self ](data, error) in
            if let error = error { // Error occured
                // Call UI error delegate method
                self.delegate.updateUIWithError(error: error)
                return
            }

            self.delegate.updateUIWithData(routes: data)

        }
    }
}
