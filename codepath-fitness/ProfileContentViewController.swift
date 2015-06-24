//
//  profileContentViewController.swift
//  codepath-fitness
//
//  Created by Patrick Weiss on 6/20/15.
//  Copyright (c) 2015 PPK Inc. All rights reserved.
//

import UIKit

class ProfileContentViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileDistributionView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 320, height: 910)

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


}
