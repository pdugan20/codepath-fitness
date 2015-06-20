//
//  PlaylistViewController.swift
//  codepath-fitness
//
//  Created by Patrick on 6/10/15.
//  Copyright (c) 2015 PPK Inc. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var playlistTableView: UITableView!
    
    // Declare parent exercise array
    var exerciseArray: NSArray! = []
    
    // Declare master of displayed exercises
    var exerciseDisplayCount = 0

    // Declare cells for each top-level summary item
    @IBOutlet weak var muscleGroupNavCell: UIView!
    @IBOutlet weak var locationNavCell: UIView!
    @IBOutlet weak var timeNavCell: UIView!
    
    // Set UI colors to be used in playlist view
    var borderColor : UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.0, alpha: 1.0)
    
    // Declare individual exercise dictionaries
    var jogDict = [
        "name" : "Light jog", 
        "intensity" : "low", 
        "duration" : "5",
        "workoutGroup" : "Warmup",
        "muscleGroup" : "Full Body",
        "imageGroup" : ["",""],
        "reps": "0",
        "sets": "1",
        "equipmentRequired" : "None",
        "description" : "Warm up your muscles and get your heart rate up."]
    
    var dumbellPressDict = [
        "name" : "Dumbbell bench press", 
        "intensity" : "low", 
        "duration" : "5",
        "workoutGroup" : "Chest",
        "muscleGroup" : "Upper Body",
        "imageGroup" : ["exercise03", "exercise09"],
        "reps": "6-10",
        "sets": "3",
        "equipmentRequired" : "Dumbbells",
        "description" : "Warm up your muscles and get your heart rate up."]
    
    var bentOverRowDict = [
        "name" : "Bent over row", 
        "intensity" : "low", 
        "duration" : "4",
        "workoutGroup" : "Back",
        "muscleGroup" : "Upper Body",
        "imageGroup" : ["exercise03", "exercise09"],
        "reps": "8-12",
        "sets": "3",
        "equipmentRequired" : "Dumbbells",
        "description" : "Warm up your muscles and get your heart rate up."]
    
    var squatDict = [
        "name" : "Squats", 
        "intensity" : "low", 
        "duration" : "3",
        "workoutGroup" : "Quadriceps",
        "muscleGroup" : "Lower Body",
        "imageGroup" : ["exercise01", "exercise06"],
        "reps": "20",
        "sets": "3",
        "equipmentRequired" : "None",
        "description" : "Warm up your muscles and get your heart rate up."]
    
    var stepUpDict = [
        "name" : "Step up with curl", 
        "intensity" : "low", 
        "duration" : "6",
        "workoutGroup" : "Legs, Biceps",
        "muscleGroup" : "Full Body",
        "imageGroup" : ["exercise01", "exercise03"],
        "reps": "10",
        "sets": "2",
        "equipmentRequired" : "Dumbbells",
        "description" : "Warm up your muscles and get your heart rate up."]
    
    var standingDumbbellDict = [
        "name" : "Standing dumbbell shoulder press", 
        "intensity" : "low", 
        "duration" : "4",
        "workoutGroup" : "Shoulders",
        "muscleGroup" : "Upper Body",
        "imageGroup" : ["exercise04", "exercise08"],
        "reps": "8-10",
        "sets": "3",
        "equipmentRequired" : "Dumbbells",
        "description" : "Warm up your muscles and get your heart rate up."]
    
    var tricepExtensionDict = [
        "name" : "Bent over tricep extension", 
        "intensity" : "low", 
        "duration" : "5",
        "workoutGroup" : "Triceps",
        "muscleGroup" : "Upper Body",
        "imageGroup" : ["exercise03", "exercise07"],
        "reps": "8-12",
        "sets": "3",
        "equipmentRequired" : "Dumbbells",
        "description" : "Warm up your muscles and get your heart rate up."]
    
    var legRaiseDict = [
        "name" : "Leg raises", 
        "intensity" : "low", 
        "duration" : "3",
        "workoutGroup" : "Abs",
        "muscleGroup" : "Core",
        "imageGroup" : ["exercise03", "exercise07"],
        "reps": "10-15",
        "sets": "4",
        "equipmentRequired" : "Pull-up Bar",
        "description" : "Warm up your muscles and get your heart rate up."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Style nav cells
        muscleGroupNavCell.layer.borderColor = borderColor.CGColor
        muscleGroupNavCell.layer.borderWidth = 1.0
        timeNavCell.layer.borderColor = borderColor.CGColor
        timeNavCell.layer.borderWidth = 1.0
        locationNavCell.layer.borderColor = borderColor.CGColor
        locationNavCell.layer.borderWidth = 1.0
        
        // Setup initial tableView
        playlistTableView.delegate = self
        playlistTableView.dataSource = self
        
        // API url
        var clientId = "BpmHUyPDIDaWYqoSL5rTcj27ryCj9N29"
        var fitnessApiUrl = NSURL(string: "https://www.kimonolabs.com/api/bfcfz33q?apikey=\(clientId)")!
        
        // Add exercises to an array
        exerciseArray = [jogDict, dumbellPressDict, bentOverRowDict, squatDict, stepUpDict, standingDumbbellDict, tricepExtensionDict, legRaiseDict]
        
        // Networking request for JSON feed
        var request = NSURLRequest(URL: fitnessApiUrl)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            // var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
            // println(responseDictionary)
            // self.exerciseArray = responseDictionary["results"] as! NSArray
            // println(self.exerciseArray)
            // self.playlistTableView.reloadData()
        }
        
    }
    
    // View for the cell in the TableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Variables for debugging
        // println("section \(indexPath.section)")
        // println("row \(indexPath.row)")
        // println("combined \(indexPath.row + indexPath.section)")
        // println("exerciseDisplayCount \(exerciseDisplayCount)")
        
        exerciseDisplayCount = (indexPath.row + indexPath.section) - 1
        if exerciseDisplayCount == -1 {
            exerciseDisplayCount = 0
        }
        
        // If row is even (summary exercise cell)
        if indexPath.row % 2 == 0 {
            
            // Define exerciseCell
            var cell = playlistTableView.dequeueReusableCellWithIdentifier("ExerciseCell") as! ExerciseCell
        
            var exerciseName = exerciseArray[exerciseDisplayCount]["name"] as? String
            var exerciseDuration = exerciseArray[exerciseDisplayCount]["duration"] as? String
            var exerciseIntensity = exerciseArray[exerciseDisplayCount]["intensity"] as? String
        
            // Populate exerciseCell
            cell.exerciseLabel.text = exerciseName!.capitalizedString
            cell.durationLabel.text = exerciseDuration!.capitalizedString
            cell.intensityLabel.text = (exerciseIntensity! + " Intensity").capitalizedString
        
            // Hide icons and full-screen images on initial view load
            cell.laterIconImageView.alpha = 0
            cell.archiveIconImageView.alpha = 0
        
            return cell

        // If row is odd (detailed exercise cell)
        } else {
            
            // Define exerciseDetailCell
            var cell = playlistTableView.dequeueReusableCellWithIdentifier("ExerciseDetailCell") as! ExerciseDetailCell
            var exerciseDescription = exerciseArray[exerciseDisplayCount]["description"] as? String
            
            cell.exerciseDescriptionTextField.textAlignment = .Center
            cell.exerciseDescriptionTextField.text = exerciseDescription
            
            return cell
        }
        
    }
    
    // How many rows in TableView (2 per section)
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return exerciseArray.count
        return 2
    }
    
    // How many sections in the TableView (1 per exercise)
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return exerciseArray.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Determine which row was selected
        var cell = sender as! UITableViewCell
        var indexPath = playlistTableView.indexPathForCell(cell)
        
        // Get the view controller that we're transitioning to.
        var exerciseDetailViewController = segue.destinationViewController as! ExerciseDetailViewController
        
        // Set the data of the view controller
        var exerciseName = exerciseArray[indexPath!.row]["name"] as? String
        var exerciseDuration = exerciseArray[indexPath!.row]["duration"] as? String
        var exerciseIntensity = exerciseArray[indexPath!.row]["intensity"] as? String
        var exerciseDescription  = exerciseArray[indexPath!.row]["description"] as? String
        
        // Pass through the data into the child of the segue
        exerciseDetailViewController.exerciseName = exerciseName
        exerciseDetailViewController.exerciseIntensity = exerciseIntensity
        exerciseDetailViewController.exerciseDuration = exerciseDuration
        exerciseDetailViewController.exerciseDescription = exerciseDescription
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Monday's Playlist"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "SFUIText-Bold", size: 18)!,  NSForegroundColorAttributeName: UIColor.blackColor()]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
