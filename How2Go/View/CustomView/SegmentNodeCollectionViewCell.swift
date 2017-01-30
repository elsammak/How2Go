//
//  SegmentNodeCollectionViewCell.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/29/17.
//  Copyright © 2017 How2Go. All rights reserved.
//
/// SegmentNode class which represnts a single Segment Node in TransitLine view.
import UIKit

class SegmentNodeCollectionViewCell: UICollectionViewCell {

    // IBOutlets
    @IBOutlet weak var logoView: UIWebView!
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var rightLine: UIView!
    @IBOutlet weak var leftLine: UIView!
    @IBOutlet weak var segmentName: UILabel!
    @IBOutlet weak var numberOfStops: UILabel!
    @IBOutlet weak var travelMode: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    // Properties
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

    // MARK: - Inits
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Update UI method
    func updateUI() {
        segmentName.text = segment.name

        if segment.numberOfStops > 1 {
            numberOfStops.text = String.localizedStringWithFormat(NSLocalizedString("transitline.stops", comment: "%d stops"), segment.numberOfStops)
        } else {
            numberOfStops.text = String.localizedStringWithFormat(NSLocalizedString("transitline.stop", comment: "%d stop"), segment.numberOfStops)
        }

        travelMode.text = NSLocalizedString(segment.travelMode.rawValue, comment: "Travel mode as string")

        DispatchQueue.main.async(execute: {
            self.logoView.loadSVGImage(imageUrl: (self.segment.iconUrl))
        })
        segmentView.backgroundColor = UIColor(hexString: segment.color)

        timeLabel.text = String.localizedStringWithFormat(NSLocalizedString("transitline.minutes", comment: "%d minutes"), segment.totalTime)

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
