//
//  RouteDetailsViewController.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/28/17.
//  Copyright © 2017 How2Go. All rights reserved.
//

import UIKit

let segmentsSegue = "SegmentsSegue"
let stopsSegue = "StopssSegue"

class RouteDetailsViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var previousButton: UIButton!
    var segmentsViewController: SegmentsViewController?
    var stopsViewController: StopsViewController?
    var currentSelectedRouteIndex: Int = 0
    var currentRoute: Route? = nil
    var routesArray: [Route] = [] {
        didSet {
            
            adjustButtonsStatus()
            updateUI()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK:- Update UI
    func updateUI() {
        
        currentRoute = routesArray[currentSelectedRouteIndex]
        segmentsViewController?.segmentsArray = (currentRoute?.segments)!
        print(currentRoute?.provider?.displayName)
    }
    
    // MARK:- IBAcions
    
    @IBAction func switchToNextRoute(_ sender: Any) {
        
        if currentSelectedRouteIndex  < routesArray.count {
            
            currentSelectedRouteIndex = currentSelectedRouteIndex + 1
            adjustButtonsStatus()
            updateUI()
        }
        
    }
    
    @IBAction func switchToPreviousRoute(_ sender: Any) {
        
        if currentSelectedRouteIndex <= 0 {
            currentSelectedRouteIndex = currentSelectedRouteIndex + 1
            adjustButtonsStatus()
            updateUI()
        }        
    }

    // MARK:- Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segmentsSegue {
            
            segmentsViewController = segue.destination as? SegmentsViewController
        }
        else if segue.identifier == stopsSegue {
            stopsViewController = segue.destination as? StopsViewController
        }
    }

    fileprivate func adjustButtonsStatus() {
        
        if currentSelectedRouteIndex + 1 >= routesArray.count {
            nextButton.isEnabled = false
            if routesArray.count > 1 {
                previousButton.isEnabled = true
            }
        }
        else if currentSelectedRouteIndex <= 0 {
            previousButton.isEnabled = false
            if routesArray.count > 1 {
                nextButton.isEnabled = true
            }
            return
        }
        else {
            nextButton.isEnabled = true
            previousButton.isEnabled = true
        }
    }
}
