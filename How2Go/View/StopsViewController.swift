//
//  StopsViewController.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/28/17.
//  Copyright © 2017 How2Go. All rights reserved.
//

import UIKit

class StopsViewController: UIViewController {

    var stopsArray: [Stop] = [] {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK:- Update UI
    private func updateUI() {
        print("Stops count: \(stopsArray.count)")
    }

}
