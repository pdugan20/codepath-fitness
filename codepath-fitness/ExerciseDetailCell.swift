//
//  ExerciseDetailCell.swift
//  codepath-fitness
//
//  Created by Patrick Dugan on 6/18/15.
//  Copyright (c) 2015 PPK Inc. All rights reserved.
//

import UIKit

class ExerciseDetailCell: UITableViewCell {

    @IBOutlet weak var exerciseDescriptionTextField: UITextView!
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var exerciseCompleteImageView: UIImageView!
    @IBOutlet weak var favoriteViewContainer: UIView!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var workoutCompleteButton: UIButton!
    @IBOutlet weak var expandedExerciseView: UIView!
    
    // Used for favorite button toggle
    var isHighLighted:Bool = false
    
    let heartPoint = CGPointMake(160, 150)
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func didFavoriteExercise(sender: UIButton) {
        
        var heartPointObject = NSValue(CGPoint: heartPoint)
        
        dispatch_async(dispatch_get_main_queue(), {
            if self.isHighLighted == false {
                sender.highlighted = true;
                self.isHighLighted = true
                self.favoriteButton.setImage(UIImage(named: "heart_icon_filled.png"), forState: UIControlState.Highlighted)
//                self.expandedExerciseView.makeToast(nil , duration: 1.5, position: heartPointObject, image: UIImage(named: "heart_icon_filled.png"))
            } else {
                sender.highlighted = false;
                self.isHighLighted = false
                self.favoriteButton.setImage(UIImage(named: "heart_icon_stroke.png"), forState: UIControlState.Normal)
                // self.favoriteLabel.text = "Favorite"
            }
        });
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
