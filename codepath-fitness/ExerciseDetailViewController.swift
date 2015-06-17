//
//  ExerciseDetailViewController.swift
//  codepath-fitness
//
//  Created by Patrick on 6/10/15.
//  Copyright (c) 2015 PPK Inc. All rights reserved.
//

import UIKit

class ExerciseDetailViewController: UIViewController {

    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var intensityLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var exerciseName: String!
    var exerciseDuration: String!
    var exerciseIntensity: String!
    var exerciseDescription: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseLabel.text = exerciseName
        intensityLabel.text = exerciseIntensity
        durationLabel.text = exerciseDuration
        descriptionLabel.text = exerciseDescription
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
