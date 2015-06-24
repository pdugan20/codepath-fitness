//
//  profileContentViewController.swift
//  codepath-fitness
//
//  Created by Patrick Weiss on 6/20/15.
//  Copyright (c) 2015 PPK Inc. All rights reserved.
//

import UIKit

class ProfileContentViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileDistributionView: UIImageView!
    
    @IBOutlet weak var profileHeadImageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 320, height: 910)
        scrollView.delegate = self
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var offset = Float(scrollView.contentOffset.y)
        
        var imageAlpha = convertValue(offset, r1Min: 0, r1Max: 568, r2Min: 0, r2Max: 1)
        
        
        if scrollView.contentOffset.y <= 80 {
            profileHeadImageView.alpha = 1
        } else {
            profileHeadImageView.alpha = ((scrollView.contentOffset.y)/80)
        }
        
        

        println("content offset: \(scrollView.contentOffset.y)")
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapToSeeDistribution(sender: AnyObject) {
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.profileView.alpha = 0
            self.profileDistributionView.alpha = 1
        })
        
    }

    @IBAction func onTapToDismissModal(sender: AnyObject) {
        
        println("tapping to dismiss")
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.profileView.alpha = 1
            self.profileDistributionView.alpha = 0
        })
        
    }

    func convertValue(value: Float, r1Min: Float, r1Max: Float, r2Min:
        Float, r2Max: Float) -> Float {
            var ratio = (r2Max - r2Min) / (r1Max - r1Min)
            return value * ratio + r2Min - r1Min * ratio
    }

}
