//
//  ViewController.swift
//  Parallax
//
//  Created by David Casserly on 27/08/2015.
//  Copyright (c) 2015 DevedUpLtd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var collectionViewLayout: UICollectionViewFlowLayout!
    var stretchyConstraints: [NSLayoutConstraint]?
    
    // MARK: DataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: ImageCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCollectionViewCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        cell.label.text = "Cell \(indexPath.row)"
        cell.backgroundImageView.image = UIImage(named: "Parallax \(indexPath.row + 1)")
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if 0 == indexPath.row {
            self.createStretchyImageConstraintsOnCell(cell as! ImageCollectionViewCell)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if 0 == indexPath.row {
            self.resetStretchyImageConstraintsOnCell(cell as! ImageCollectionViewCell)
        }
    }
    
    // MARK: Delegate
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return collectionView.bounds.size;
    }
    
    // MARK: Stretchy Image Constraint
    
    func resetStretchyImageConstraintsOnCell(imageCell:ImageCollectionViewCell) {
        if let stretchyConstraints = self.stretchyConstraints {
            self.view.removeConstraints(stretchyConstraints)
        }
        imageCell.imageTopConstraint.active = true
        imageCell.clipsToBounds = true
    }
    
    func createStretchyImageConstraintsOnCell(imageCell:ImageCollectionViewCell) {
        
        // Disable current image top constraint and prepare image
        imageCell.imageTopConstraint.active = false
        imageCell.clipsToBounds = false
        imageCell.contentMode = UIViewContentMode.ScaleAspectFill
        
        // Create array to store constraints
        stretchyConstraints = []
        
        // Now create a constraint from the image to the topLayout guide so that it sticks to it
        // The image must also be setup with aspect fill so the image stretches
        let stretchyConstraint = NSLayoutConstraint(
            item: imageCell.backgroundImageView,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.topLayoutGuide,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 0.0)
        stretchyConstraint.priority = 750
        stretchyConstraints!.append(stretchyConstraint)
        
        // This constraint allows you to push the scroll up and not squash the image
        let squashyConstraint = NSLayoutConstraint(
            item: imageCell.backgroundImageView,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.LessThanOrEqual,
            toItem: self.collectionView,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 0.0)
        stretchyConstraints!.append(squashyConstraint)
        
        // Add the constraints
        self.view.addConstraints(stretchyConstraints!)
    }

}

