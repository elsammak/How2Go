//
//  RouteViewController.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/28/17.
//  Copyright © 2017 How2Go. All rights reserved.
//
/// Main class represents all Route data includes Map and route details.
import UIKit
import MapKit

// Class constants
private let normalHeightConstraint: CGFloat = 168.0
private let scrollViewContentHeight: CGFloat = 469.0
private let expandedHeightConstraint: CGFloat = UIScreen.main.bounds.height - 30
private let routeDetailsSegue = "RouteDetailsSegue"

class RouteViewController: UIViewController, RoutesDelegate, MKMapViewDelegate, RouteDetailsDelegate {

    // Properties
    var isMapViewExpanded: Bool = false
    var routeDetailsViewController: RouteDetailsViewController?

    // ViewModel
    var viewModel: RoutesViewModel = RoutesViewModel()

    // IBoutlets
    @IBOutlet weak var mapHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var horizontalScrollView: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var loadingView: UIView!

    // MARK: - Inits
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.getRouteData()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        horizontalScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: scrollViewContentHeight)
    }

    // MARK: - IBActions
    @IBAction func expandOrShringMapView(_ sender: Any) {

        if isMapViewExpanded {
            mapHeightConstraint.constant = normalHeightConstraint
        } else {
            mapHeightConstraint.constant = expandedHeightConstraint
        }

        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })

        isMapViewExpanded = !isMapViewExpanded
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == routeDetailsSegue {

            routeDetailsViewController = segue.destination as? RouteDetailsViewController
            routeDetailsViewController?.routeDetailsDelegate = self
        }
    }

    // MARK: - RoutesDelegate methods
    func updateUIWithData(routes: [Route]?) {
        guard let routesArray = routes else {
            return
        }

        // Hide loading view
        UIView.animate(withDuration: 0.5, animations: {
            self.loadingView.alpha = 0
        })
        // Update current details view
        routeDetailsViewController?.routesArray = routesArray
        pageController.numberOfPages = routesArray.count
        pageController.currentPage = (routeDetailsViewController?.currentSelectedRouteIndex)!

    }
    func updateUIWithError(error: Error) {

        let alert = UIAlertController(title: NSLocalizedString("error.title", comment: "Error"),
                                      message: error.localizedDescription,
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("error.retry", comment: "Retry"), style: UIAlertActionStyle.default, handler: { _ in
            self.viewModel.getRouteData()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("error.cancel", comment: "Cancel"), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - RouteDetailsDelegate
    func updateDataForCurrentRoute(currentRoute: Route, currentIndex: Int) {

        // Update PageController
        pageController.currentPage = currentIndex

        // Update map
         mapView.removeOverlays(mapView.overlays)

        // Draw route
        for segment in currentRoute.segments {
            if let polyline = MKPolyline(encodedString: segment.polyline) {
                self.mapView.add(polyline, level: MKOverlayLevel.aboveRoads)
            }
        }

        // Focus map
        if let first = mapView.overlays.first {
            let rect = mapView.overlays.reduce(first.boundingMapRect, { MKMapRectUnion($0, $1.boundingMapRect) })
            mapView.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0), animated: true)
        }
    }
    // MARK: - MKMapViewDelegate
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
