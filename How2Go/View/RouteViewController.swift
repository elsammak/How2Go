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

class RouteViewController: UIViewController {

    var isMapViewExpanded: Bool = false
    @IBOutlet weak var mapHeightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
