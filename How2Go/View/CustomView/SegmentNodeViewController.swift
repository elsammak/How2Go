//
//  SegmentNodeViewController.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/28/17.
//  Copyright © 2017 How2Go. All rights reserved.
//

import UIKit

class SegmentNodeViewController: UIViewController {

    //IBOutlets
    @IBOutlet weak var logoView: UIWebView!
    @IBOutlet weak var rightLine: UIView!
    @IBOutlet weak var leftLine: UIView!
    
    
    var segment: Segment = Segment() {
        didSet {
            updateUI()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func updateUI() {
        
    }
    
    func removeFirstLine() {
        
    }
    func removeLastLine() {
        
    }
}
