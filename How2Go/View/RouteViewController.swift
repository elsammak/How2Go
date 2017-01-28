//
//  RouteViewController.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/28/17.
//  Copyright © 2017 How2Go. All rights reserved.
//

import UIKit

private let normalHeightConstraint: CGFloat = 168.0
private let routeDetailsVCHeight: CGFloat = 469.0
private let expandedHeightConstraint: CGFloat = UIScreen.main.bounds.height - 30.0
private let routeDetailsSegue = "RouteDetailsSegue"

class RouteViewController: UIViewController, RoutesDelegate {

    // Properties
    var isMapViewExpanded: Bool = false    
    var routeDetailsViewController: RouteDetailsViewController?
    
    //ViewModel
    var viewModel: RoutesViewModel = RoutesViewModel()
    
    //IBoutlets
    @IBOutlet weak var mapHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.getRouteData()
    }
    
 
    // MARK:- IBActions
    @IBAction func expandOrShringMapView(_ sender: Any) {
        
        
        if isMapViewExpanded {
            mapHeightConstraint.constant = normalHeightConstraint
        }
        else {
            mapHeightConstraint.constant = expandedHeightConstraint
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        
        isMapViewExpanded = !isMapViewExpanded
    }
    
    // MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == routeDetailsSegue {
            
            routeDetailsViewController = segue.destination as? RouteDetailsViewController
        }
    }

    // MARK:- RoutesDelegate methods
    func updateUIWithData(routes: [Route]?) {
        guard let routesArray = routes else {
            return
        }        
        // Update current details view
        routeDetailsViewController?.routesArray = routesArray
        
    }
    func updateUIWithError(error: Error) {
        
    }

}
