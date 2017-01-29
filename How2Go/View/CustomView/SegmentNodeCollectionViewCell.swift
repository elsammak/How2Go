//
//  SegmentNodeCollectionViewCell.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/29/17.
//  Copyright © 2017 How2Go. All rights reserved.
//

import UIKit

class SegmentNodeCollectionViewCell: UICollectionViewCell {

    //IBOutlets
    @IBOutlet weak var logoView: UIWebView!
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var rightLine: UIView!
    @IBOutlet weak var leftLine: UIView!
    @IBOutlet weak var segmentName: UILabel!
    @IBOutlet weak var numberOfStops: UILabel!
    @IBOutlet weak var travelMode: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var isExpanded: Bool = false
    var segment: Segment = Segment() {
        didSet {
            updateUI()
        }
    }
    
    var stop: Stop = Stop() {
        didSet {
            self.backgroundColor = UIColor.brown
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateUI() {
        segmentName.text = segment.name
        numberOfStops.text = String.init(format: "\(segment.numberOfStops) stops")
        travelMode.text = segment.travelMode.rawValue
        
        DispatchQueue.main.async(execute: {
            self.logoView.loadSVGImage(imageUrl: (self.segment.iconUrl))
        })
        segmentView.backgroundColor = UIColor(hexString: segment.color)
        timeLabel.text = String.init(format: "\(segment.totalTime) minutes")
        
        leftLine.alpha = 1
        rightLine.alpha = 1
        
    }
    
    func removeFirstLine() {
        leftLine.alpha = 0
    }
    func removeLastLine() {
        rightLine.alpha = 0
    }
}
