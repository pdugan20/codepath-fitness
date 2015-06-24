//
//  NuxViewController.swift
//  codepath-fitness
//
//  Created by Patrick on 6/10/15.
//  Copyright (c) 2015 PPK Inc. All rights reserved.
//

import UIKit

class NuxViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var pager: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentSize = CGSizeMake(1280, 568)
        scrollView.delegate = self
        skipButton.alpha = 0
    }
    
    // Sets status bar style to either light or dark (default)
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        var page : Int = Int(round(scrollView.contentOffset.x / 320))
        pager.currentPage = page
        
        if pager.currentPage == 3{
            UIView.animateWithDuration(0.1, animations: {
                self.pager.alpha = 0
                self.skipButton.alpha = 1
            })
        }
            
        else {
            UIView.animateWithDuration(0.2, animations: {
                self.pager.alpha = 1
                self.skipButton.alpha = 0
            })
        }
        
    }

}
