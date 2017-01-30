//
//  TransitLineViewController.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/28/17.
//  Copyright © 2017 How2Go. All rights reserved.
//

import UIKit

// Class constants
private let nodeWidth = CGFloat(100)
private let nodeHeight = CGFloat(160)
private let segmentCellIdentifier = "SegmentCell"
private let stopCellIdentifier = "StopCell"

class TransitLineViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // Properties
    var elementsArray: [Any] = []
    var segmentsArray: [Segment] = [] {
        didSet {
            elementsArray.removeAll()
            elementsArray = segmentsArray
            reloadData()
        }
    }

    // IBOutlet
    @IBOutlet weak var transitLineCollectionView: UICollectionView!

    // MARK: - Inits
    override func viewDidLoad() {
        super.viewDidLoad()

        transitLineCollectionView?.register(UINib(nibName: "SegmentNodeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: segmentCellIdentifier)
        transitLineCollectionView?.register(UINib(nibName: "StopNodeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: stopCellIdentifier)
    }

    // MARK: - UICollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elementsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let element: Any? = elementsArray[indexPath.row]
        if elementsArray[indexPath.row] is Segment { // Segment cell

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: segmentCellIdentifier, for: indexPath)
            guard let segmentNodeCollectionViewCell = cell as? SegmentNodeCollectionViewCell else {
                return cell
            }
            segmentNodeCollectionViewCell.segment = element as! Segment

            if indexPath.row == 0 {
                segmentNodeCollectionViewCell.removeFirstLine()
            } else if indexPath.row == elementsArray.count - 1 {
                segmentNodeCollectionViewCell.removeLastLine()
            }
            if elementsArray.count == 1 {
                segmentNodeCollectionViewCell.removeFirstLine()
                segmentNodeCollectionViewCell.removeLastLine()
            }
            return segmentNodeCollectionViewCell
        } else if elementsArray[indexPath.row] is Stop { // Stop cell

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: stopCellIdentifier, for: indexPath)
            guard let stopNodeCollectionViewCell = cell as? StopNodeCollectionViewCell else {
                return cell
            }
            stopNodeCollectionViewCell.stop = element as! Stop

            if indexPath.row == 0 {
                stopNodeCollectionViewCell.removeFirstLine()
            } else if indexPath.row == elementsArray.count - 1 {
                stopNodeCollectionViewCell.removeLastLine()
            }

            return stopNodeCollectionViewCell

        }

        return UICollectionViewCell()

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {

        return CGSize(width: nodeWidth, height: nodeHeight)
    }

    // MARK: - UICollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard elementsArray.count > 1 else {
            return
        }
        var segmentIndex = indexPath.row
        if elementsArray[segmentIndex] is Stop {
            segmentIndex = getCurrentExpandedSegmentIndex(currentStopIndex: segmentIndex)
        }

        if elementsArray[segmentIndex] is Segment { // Check for status
            let segmentValue = elementsArray[segmentIndex] as? Segment
            guard var segment = segmentValue else { return }
            let stopsArray = segment.stops
            var index = segmentIndex + 1
            for stop in stopsArray {
                if segment.isExpanded { // Shrink
                    elementsArray.remove(at: index)
                } else { //Expand
                    elementsArray.insert(stop, at: index)
                    index = index + 1
                }
            }
            segment.isExpanded = !segment.isExpanded
            elementsArray[segmentIndex] = segment

        }

        reloadData()
    }

    // MARK: - Private helpers
    private func getCurrentExpandedSegmentIndex(currentStopIndex: Int) -> Int {
        var segmentIndex = currentStopIndex

        for i in (0...currentStopIndex).reversed() {
            if elementsArray[i] is Segment {
                segmentIndex = i
                break
            }
        }
        return segmentIndex

    }

    private func reloadData() {
        let range = Range(uncheckedBounds: (0, transitLineCollectionView.numberOfSections))
        let indexSet = IndexSet(integersIn: range)
        transitLineCollectionView.reloadSections(indexSet)
    }
}
