//
//  RouteViewController.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/28/17.
//  Copyright © 2017 How2Go. All rights reserved.
//

import UIKit
import MapKit

private let normalHeightConstraint: CGFloat = 168.0
private let routeDetailsVCHeight: CGFloat = 469.0
private let expandedHeightConstraint: CGFloat = UIScreen.main.bounds.height - 30.0
private let routeDetailsSegue = "RouteDetailsSegue"

class RouteViewController: UIViewController, RoutesDelegate, MKMapViewDelegate {

    // Properties
    var isMapViewExpanded: Bool = false    
    var routeDetailsViewController: RouteDetailsViewController?
    
    //ViewModel
    var viewModel: RoutesViewModel = RoutesViewModel()
    
    //IBoutlets
    @IBOutlet weak var mapHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var mapView: MKMapView!
    
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
        
        let polyline = MKPolyline(encodedString: "uvr_I{yxpABuAFcAp@yHvAwNr@iGPwAh@a@jAg@")
        self.mapView.add(polyline!, level: MKOverlayLevel.aboveRoads)
        
    }
    func updateUIWithError(error: Error) {
        
    }

    // MARK:- MKMapViewDelegate
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        
        if overlay is MKPolyline {
            // draw the track
            let polyLine = overlay
            let polyLineRenderer = MKPolylineRenderer(overlay: polyLine)
            polyLineRenderer.strokeColor = UIColor.blue
            polyLineRenderer.lineWidth = 2.0
            
            return polyLineRenderer
        }
        
        return MKOverlayRenderer()
    }
    
    
}
