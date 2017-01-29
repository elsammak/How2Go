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

class RouteViewController: UIViewController, RoutesDelegate, MKMapViewDelegate, RouteDetailsDelegate {

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
            routeDetailsViewController?.routeDetailsDelegate = self
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
        
        let alert = UIAlertController(title: "Error",
                                      message: error.localizedDescription,
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.default, handler: { _ in
            self.viewModel.getRouteData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK:- RouteDetailsDelegate
    func updateMapForCurrentRoute(currentRoute: Route) {
                
        // Update map
         mapView.removeOverlays(mapView.overlays)
        
        //Draw route
        for segment in currentRoute.segments {
            if let polyline = MKPolyline(encodedString: segment.polyline){
                self.mapView.add(polyline, level: MKOverlayLevel.aboveRoads)
            }
        }
        //Focus map
        if let first = mapView.overlays.first {
            let rect = mapView.overlays.reduce(first.boundingMapRect, {MKMapRectUnion($0, $1.boundingMapRect)})
            mapView.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0), animated: true)
        }
    }
    // MARK:- MKMapViewDelegate
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        
        if overlay is MKPolyline {
            // draw the track
            let polyLine = overlay
            let polyLineRenderer = MKPolylineRenderer(overlay: polyLine)
            polyLineRenderer.strokeColor = UIColor.cyan
            polyLineRenderer.lineWidth = 2.0
            
            return polyLineRenderer
        }
        
        return MKOverlayRenderer()
    }
    
    
}
