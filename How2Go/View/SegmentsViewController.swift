//
//  SegmentsViewController.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/28/17.
//  Copyright © 2017 How2Go. All rights reserved.
//

import UIKit

private let nodeWidth = 100
class SegmentsViewController: UIViewController {

    var segmentsArray: [Segment] = [] {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var segmentsScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK:- Update UI
    private func updateUI() {
        print("Segment count: \(segmentsArray.count)")
        
        var index = 0
        // Create nodes and add them to self view
        for segment in segmentsArray {
            var segmentNodeView = SegmentNodeViewController()
            var origin = segmentNodeView.view.frame.origin
            origin.x = CGFloat(index * nodeWidth)
            segmentNodeView.view.frame.origin = origin
            self.segmentsScrollView.addSubview(segmentNodeView.view)
            index = index + 1
        }
        self.segmentsScrollView.contentSize = CGSize(width: CGFloat(index * nodeWidth), height: 80)
    }
}
