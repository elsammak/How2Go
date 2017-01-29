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

protocol RouteDetailsDelegate {
    func updateMapForCurrentRoute(currentRoute: Route)
}
class RouteDetailsViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var providerLogo: UIWebView!
    @IBOutlet weak var segmentsLabel: UILabel!
    @IBOutlet weak var stopsLabel: UILabel!
    @IBOutlet weak var propertiesLabel: UILabel!
    
    var segmentsViewController: SegmentsViewController?
    var stopsViewController: StopsViewController?
    var routeDetailsDelegate: RouteDetailsDelegate? = nil
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
        
        routeDetailsDelegate?.updateMapForCurrentRoute(currentRoute: currentRoute!)
        
        segmentsViewController?.segmentsArray = (currentRoute?.segments)!
        
        typeLabel.text = (currentRoute?.type).map { $0.rawValue }
        priceLabel.text = currentRoute?.price.getFormatValue()
        DispatchQueue.main.async(execute: {
            self.providerLogo.loadSVGImage(imageUrl: (self.currentRoute?.provider?.providerIconUrl)!)
        })
        
        if let segmentsCount = currentRoute?.segments.count {
            segmentsLabel.text = String.init(format: "\(segmentsCount) segments")
        }
        if let stopsCount = currentRoute?.getNumberOfStops() {
            stopsLabel.text = String.init(format: "\(stopsCount) stops")
        }
                
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
        
        if currentSelectedRouteIndex > 0 {
            currentSelectedRouteIndex = currentSelectedRouteIndex - 1
            adjustButtonsStatus()
            updateUI()
        }        
    }
    @IBAction func logoButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Open itunes page",
                                      message: "Are your sure you want to open in itunes",
                                      preferredStyle: UIAlertControllerStyle.alert)
//        alert.view.tintColor = UIColor.blueSystemColor()
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { _ in
            guard let url = URL(string: (self.currentRoute?.provider?.itunesUrl)!) else { return }
            UIApplication.shared.openURL(url)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func propertiesButtonPressed(_ sender: Any) {
        
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
