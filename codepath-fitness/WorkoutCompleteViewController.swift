//
//  WorkoutCompleteViewController.swift
//  codepath-fitness
//
//  Created by Patrick on 6/17/15.
//  Copyright (c) 2015 PPK Inc. All rights reserved.
//

import UIKit
import Social

class WorkoutCompleteViewController: UIViewController {

    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var workoutCompletedView: UIView!
    @IBOutlet weak var workoutCompletedImages: UIImageView!
    @IBOutlet weak var fbShareButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        var images = UIImage.animatedImageNamed("Complete_Circle", duration: 5)
//        workoutCompletedImages.image = images
//        
//        delay(4.7, { () -> () in
//            UIView.animateWithDuration(0.3, animations: { () -> Void in
//                self.workoutCompletedView.alpha = 0
//            })
//        })
//
//
//        
//        
    }
//
//    @IBAction func didPressReset(sender: AnyObject) {
//        dismissViewControllerAnimated(true, completion: nil)
//    }
    
    @IBAction func onShareButtonTap(sender: AnyObject) {
        
        let firstActivityItem = "Hey, checkout this workout I crushed using Flex Fitness!"
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [firstActivityItem], applicationActivities: nil)
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
    }
    
    
// Code for creating a button to share directly on Facebook
//    @IBAction func onTaptoFBShare(sender: AnyObject) {
//        
//        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
//            var fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
//            
//            self.presentViewController(fbShare, animated: true, completion: nil)
//            
//        } else {
//            var alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
//            
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//            self.presentViewController(alert, animated: true, completion: nil)
//        }
//        
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
