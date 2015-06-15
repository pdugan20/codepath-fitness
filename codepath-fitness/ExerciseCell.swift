//
//  ExerciseCell.swift
//  codepath-fitness
//
//  Created by Patrick on 6/12/15.
//  Copyright (c) 2015 PPK Inc. All rights reserved.
//

import UIKit

class ExerciseCell: UITableViewCell {

    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var intensityLabel: UILabel!
    
    @IBOutlet weak var archiveIconImageView: UIImageView!
    @IBOutlet weak var laterIconImageView: UIImageView!
    @IBOutlet weak var exerciseCellView: UIView!
    
    let blueColor = UIColor(red: 68/255, green: 170/255, blue: 210/255, alpha: 1)
    let yellowColor = UIColor(red: 254/255, green: 202/255, blue: 22/255, alpha: 1)
    let brownColor = UIColor(red: 206/255, green: 150/255, blue: 98/255, alpha: 1)
    let greenColor = UIColor(red: 85/255, green: 213/255, blue: 80/255, alpha: 1)
    let redColor   = UIColor(red: 231/255, green: 61/255, blue: 14/255, alpha: 1)
    let grayColor = UIColor.lightGrayColor()
    
    var openMenuOffset = CGFloat(300)
    var mainViewCenter = CGPoint()
    var messageCenter = CGPoint()
    var leftViewOrigin = CGPoint()
    var rightViewOrigin = CGPoint()
    
    var gestureViewStartingOrigin: CGPoint!
    var exerciseCellViewStartingOrigin: CGPoint!
    var laterIconStartingOrigin: CGPoint!
    var archiveIconStartingOrigin: CGPoint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Adds a pan recognizer
        var sender = UIPanGestureRecognizer(target: self, action: "didPanExerciseCell:")
        sender.delegate = self
        addGestureRecognizer(sender)
        
    }
    
    // Message pan gesture recgonizer
    func didPanExerciseCell(sender: UIPanGestureRecognizer) {
        var location = sender.locationInView(self)
        var translation = sender.translationInView(self)
        var velocity = sender.velocityInView(self)
        
        if sender.state == UIGestureRecognizerState.Began {
            gestureViewStartingOrigin = location
            exerciseCellViewStartingOrigin = exerciseCellView.frame.origin
            laterIconStartingOrigin = laterIconImageView.frame.origin
            archiveIconStartingOrigin = archiveIconImageView.frame.origin
            
            exerciseCellView.backgroundColor = grayColor
            laterIconImageView.image = UIImage(named: "later_icon")
            archiveIconImageView.image = UIImage(named: "archive_icon")
            
            // Control dragable messageView on x-axis
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            var currentOrigin = exerciseCellViewStartingOrigin.x + location.x -
                gestureViewStartingOrigin.x
            exerciseCellView.frame.origin.x = currentOrigin
            
            // Swipe left inside of messageView
            if currentOrigin < 0 {
                
                // Later icon + gray background
                if -60 < currentOrigin {
                    self.laterIconImageView.alpha = translation.x/(60 * -1)
                    self.exerciseCellView.backgroundColor = self.grayColor
                    
                    // Later icon + yellow background
                } else if (-260 <= currentOrigin) && (currentOrigin < -60) {
                    self.laterIconImageView.alpha = 1
                    self.laterIconImageView.frame.origin.x = self.laterIconStartingOrigin.x +
                        location.x - self.gestureViewStartingOrigin.x + 60
                    
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.exerciseCellView.backgroundColor = self.yellowColor
                        self.laterIconImageView.image = UIImage(named: "later_icon")
                    })
                    
                    // List icon + brown background
                } else if currentOrigin < -260 {
                    self.laterIconImageView.alpha = 1
                    self.laterIconImageView.frame.origin.x = self.laterIconStartingOrigin.x +
                        location.x - self.gestureViewStartingOrigin.x + 60
                    
                    UIView.animateWithDuration(0.3, animations: {  () -> Void in
                        self.exerciseCellView.backgroundColor = self.brownColor
                        self.laterIconImageView.image = UIImage(named: "list_icon")
                    })
                }
                
                // Swipe right inside of messageView
            } else if 0 < currentOrigin {
                
                // Archive icon + gray background
                if currentOrigin < 60 {
                    self.archiveIconImageView.frame.origin.x = 16
                    self.archiveIconImageView.alpha = translation.x/60
                    self.exerciseCellView.backgroundColor = self.grayColor
                    
                    // Archive icon + green background
                } else if (60 < currentOrigin) && (currentOrigin <= 260) {
                    self.archiveIconImageView.alpha = 1
                    self.archiveIconImageView.frame.origin.x = self.archiveIconStartingOrigin.x +
                        location.x - self.gestureViewStartingOrigin.x - 60
                    
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.exerciseCellView.backgroundColor = self.greenColor
                        self.archiveIconImageView.image = UIImage(named: "archive_icon")
                    })
                    
                    // Delete icon + green background
                } else if 260 < currentOrigin {
                    self.archiveIconImageView.alpha = 1
                    self.archiveIconImageView.frame.origin.x = self.archiveIconStartingOrigin.x +
                        location.x - self.gestureViewStartingOrigin.x - 60
                    
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.exerciseCellView.backgroundColor = self.redColor
                        self.archiveIconImageView.image = UIImage(named: "delete_icon")
                    })
                }
            }
            
            // Handle animations post-drag of messageView
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            // Swipe left inside of messageView
            if translation.x < 0 {
                
                // Snap back to original origin
                if -60 < translation.x {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.exerciseCellView.frame.origin.x = self.exerciseCellViewStartingOrigin.x
                        self.laterIconImageView.frame.origin.x = self.laterIconStartingOrigin.x
                        self.laterIconImageView.alpha = 0
                        self.exerciseCellView.backgroundColor = self.grayColor
                    })
                }
                    
                    // Complete animation (yellow background + later icon)
                else if (-260 <= translation.x) && (translation.x < -60) {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.exerciseCellView.frame.origin.x = -320
                        self.laterIconImageView.alpha = 0
                        self.exerciseCellView.backgroundColor = self.yellowColor
                        
                        // Show options imageView
                        }, completion: { (BOOL) -> Void in
                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                // self.rescheduleImageView.alpha = 1
                            })
                    })
                    
                    // Complete animation (brown background + list icon)
                } else {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.exerciseCellView.frame.origin.x = -320
                        self.laterIconImageView.alpha = 0
                        self.exerciseCellView.backgroundColor = self.brownColor
                        
                        // Show options imageView
                        }, completion: { (BOOL) -> Void in
                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                // self.listImageView.alpha = 1
                            })
                    })
                }
                
                // Swipe right inside of the messageView
            } else if 0 < translation.x {
                
                // Snap back to original origin
                if translation.x < 60 {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.exerciseCellView.frame.origin.x = self.exerciseCellViewStartingOrigin.x
                        self.archiveIconImageView.frame.origin.x = self.archiveIconStartingOrigin.x
                        self.archiveIconImageView.alpha = 0
                        self.exerciseCellView.backgroundColor = self.grayColor
                    })
                    
                    // Complete animation (green background + archive icon)
                } else if (60 < translation.x) && (translation.x <= 260) {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.exerciseCellView.frame.origin.x = 320
                        self.archiveIconImageView.alpha = 0
                        self.exerciseCellView.backgroundColor = self.greenColor
                        
                        // Hide the messageView
                        }, completion: { (BOOL) -> Void in
                            // self.hideMessageView()
                    })
                    
                    // Complete animation (red background + delete icon)
                } else {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.exerciseCellView.frame.origin.x = 320
                        self.archiveIconImageView.alpha = 0
                        self.exerciseCellView.backgroundColor = self.redColor
                        
                        // Hide the messageView
                        }, completion: { (BOOL) -> Void in
                            // self.hideMessageView()
                    })
                }
            }
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
