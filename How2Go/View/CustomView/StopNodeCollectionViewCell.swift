//
//  StopNodeCollectionViewCell.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/29/17.
//  Copyright © 2017 How2Go. All rights reserved.
//

import UIKit

class StopNodeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var stopNameLabel: UILabel!
    @IBOutlet weak var rightLine: UIView!
    @IBOutlet weak var leftLine: UIView!
    
    var stop: Stop = Stop() {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        stopNameLabel.transform = CGAffineTransform(rotationAngle: CGFloat(70.0))
    }

    func updateUI() {
        
        stopNameLabel.text = stop.name
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
