//
//  SegmentsViewController.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/28/17.
//  Copyright © 2017 How2Go. All rights reserved.
//

import UIKit

private let nodeWidth = CGFloat(100)
private let nodeHeight = CGFloat(130)
private let segmentCellIdentifier = "SegmentCell"
private let stopCellIdentifier = "StopCell"
class SegmentsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var elementsArray: [Any] = []
    var segmentsArray: [Segment] = [] {
        didSet {
            elementsArray.removeAll()
            elementsArray = segmentsArray
            self.segmentsCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var segmentsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()      
        
        segmentsCollectionView?.register(UINib(nibName: "SegmentNodeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: segmentCellIdentifier)
        segmentsCollectionView?.register(UINib(nibName: "StopNodeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: stopCellIdentifier)
    }
    
    // MARK: - UICollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elementsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: segmentCellIdentifier, for: indexPath)
        guard let segmentNodeCollectionViewCell = cell as? SegmentNodeCollectionViewCell else {
            return cell
        }
        
        let element: Any? = elementsArray[indexPath.row]
        if elementsArray[indexPath.row] is Segment {
            segmentNodeCollectionViewCell.segment = element as! Segment
        }
        else if elementsArray[indexPath.row] is Stop {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: segmentCellIdentifier, for: indexPath)
            
            segmentNodeCollectionViewCell.stop = element as! Stop
        }
        
        
        if indexPath.row == 0 {
            segmentNodeCollectionViewCell.removeFirstLine()
        }
        else if indexPath.row == elementsArray.count - 1 {
            segmentNodeCollectionViewCell.removeLastLine()
        }
        
        return segmentNodeCollectionViewCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: nodeWidth, height: nodeHeight)
    }
    
    // MARK: - UICollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let stopsArray = (elementsArray[indexPath.row] as! Segment).stops
        var index = indexPath.row
        for stop in stopsArray {
            elementsArray.insert(stop, at: index)
            index = index + 1
        }
        
        segmentsCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
}
