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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
