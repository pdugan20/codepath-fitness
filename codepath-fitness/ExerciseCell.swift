//
//  ExerciseCell.swift
//  codepath-fitness
//
//  Created by Patrick on 6/12/15.
//  Copyright (c) 2015 PPK Inc. All rights reserved.
//

import UIKit

protocol TableViewCellDelegate {
    func exerciseDeleted(exerciseIndex: Int)
}

class ExerciseCell: UITableViewCell {
    
    var delegate: TableViewCellDelegate?

    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var workoutGroupLabel: UILabel!
    @IBOutlet weak var setRepLabel: UILabel!
    
    @IBOutlet weak var archiveIconImageView: UIImageView!
    @IBOutlet weak var laterIconImageView: UIImageView!
    @IBOutlet weak var exerciseCellView: UIView!
    @IBOutlet weak var exerciseCellContentView: UIView!
    
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
        
        var exerciseIndex = exerciseLabel.tag
        
        if sender.state == UIGestureRecognizerState.Began {
            gestureViewStartingOrigin = location
            exerciseCellViewStartingOrigin = exerciseCellContentView.frame.origin
            laterIconStartingOrigin = laterIconImageView.frame.origin
            archiveIconStartingOrigin = archiveIconImageView.frame.origin
            
            exerciseCellView.backgroundColor = grayColor
            laterIconImageView.image = UIImage(named: "swap_icon")
            archiveIconImageView.image = UIImage(named: "done_icon")
            
            // Control dragable messageView on x-axis
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            var currentOrigin = exerciseCellViewStartingOrigin.x + location.x -
                gestureViewStartingOrigin.x
            exerciseCellContentView.frame.origin.x = currentOrigin
            
            // Swipe left inside of messageView
            if currentOrigin < 0 {
                
                // Later icon + gray background
                if -60 < currentOrigin {
                    self.laterIconImageView.alpha = translation.x/(60 * -1)
                    self.exerciseCellView.backgroundColor = self.grayColor
                    
                // Later icon + yellow background
                } else if (currentOrigin < -60) {
                    self.laterIconImageView.alpha = 1
                    self.laterIconImageView.frame.origin.x = self.laterIconStartingOrigin.x +
                        location.x - self.gestureViewStartingOrigin.x + 60
                    
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.exerciseCellView.backgroundColor = self.yellowColor
                        self.laterIconImageView.image = UIImage(named: "swap_icon")
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
                } else if (60 < currentOrigin) {
                    self.archiveIconImageView.alpha = 1
                    self.archiveIconImageView.frame.origin.x = self.archiveIconStartingOrigin.x +
                        location.x - self.gestureViewStartingOrigin.x - 60
                    
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.exerciseCellView.backgroundColor = self.greenColor
                        self.archiveIconImageView.image = UIImage(named: "done_icon")
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
                        self.exerciseCellContentView.frame.origin.x = self.exerciseCellViewStartingOrigin.x
                        self.laterIconImageView.frame.origin.x = self.laterIconStartingOrigin.x
                        self.laterIconImageView.alpha = 0
                        self.exerciseCellView.backgroundColor = self.grayColor
                    })
                }
                    
                    // Complete animation (yellow background + later icon)
                else if (translation.x < -60) {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.exerciseCellContentView.frame.origin.x = -320
                        self.laterIconImageView.alpha = 0
                        self.exerciseCellView.backgroundColor = self.yellowColor
                        
                        // Show options imageView
                        }, completion: { (BOOL) -> Void in
                            if self.delegate != nil {
                                self.delegate!.exerciseDeleted(exerciseIndex)
                                self.hideMessageView()
                            }
                    })
                }
                
                // Swipe right inside of the messageView
            } else if 0 < translation.x {
                
                // Snap back to original origin
                if translation.x < 60 {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.exerciseCellContentView.frame.origin.x = self.exerciseCellViewStartingOrigin.x
                        self.archiveIconImageView.frame.origin.x = self.archiveIconStartingOrigin.x
                        self.archiveIconImageView.alpha = 0
                        self.exerciseCellView.backgroundColor = self.grayColor
                    })
                    
                    // Complete animation (green background + archive icon)
                } else if (60 < translation.x) && (translation.x <= 260) {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.exerciseCellContentView.frame.origin.x = 320
                        self.archiveIconImageView.alpha = 0
                        self.exerciseCellView.backgroundColor = self.greenColor
                        
                        // Hide the messageView
                        }, completion: { (BOOL) -> Void in
                            if self.delegate != nil {
                                self.delegate!.exerciseDeleted(exerciseIndex)
                                self.hideMessageView()
                            }
                    })
                }
            }
        }
    }
    
    // Hides messageView after some user action
    func hideMessageView() {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            }, completion:
            { (BOOL) -> Void in
                self.exerciseCellContentView.frame.origin.x = 0
                self.laterIconImageView.frame.origin.x = 279
                self.laterIconImageView.image = UIImage(named: "swap_icon")
                self.laterIconImageView.alpha = 0
                self.archiveIconImageView.frame.origin.x = 16
                self.archiveIconImageView.image = UIImage(named: "done_icon")
                self.archiveIconImageView.alpha = 0
        })
    }
    
    // Adds ability for TableView to scroll and cells to pan
    override func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
