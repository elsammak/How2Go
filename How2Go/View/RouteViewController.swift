//
//  RouteViewController.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/28/17.
//  Copyright © 2017 How2Go. All rights reserved.
//

import UIKit

let normalHeightConstraint: CGFloat = 168.0
let expandedHeightConstraint: CGFloat = UIScreen.main.bounds.height - 30.0


class RouteViewController: UIViewController, RoutesDelegate {

    // Properties
    var isMapViewExpanded: Bool = false
    
    //ViewModel
    var viewModel: RoutesViewModel = RoutesViewModel()
    
    //IBoutlets
    @IBOutlet weak var mapHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.getRouteData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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

    // MARK:- RoutesDelegate methods
    func updateUIWithData(routes: [Route]?) {
        guard let routesArray = routes else {
            return
        }
        print("Count \(routesArray.count)")
        
    }
    func updateUIWithError(error: Error) {
        
    }

}
