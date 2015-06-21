//
//  PlaylistViewController.swift
//  codepath-fitness
//
//  Created by Patrick on 6/10/15.
//  Copyright (c) 2015 PPK Inc. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate {

    @IBOutlet weak var playlistTableView: UITableView!
    
    // Declare parent exercise array
    var exerciseArray: [AnyObject] = []
    
    // Declare master of displayed exercises
    var exerciseDisplayCount: Int!

    // Declare cells for each top-level summary item
    @IBOutlet weak var muscleGroupNavCell: UIView!
    @IBOutlet weak var locationNavCell: UIView!
    @IBOutlet weak var timeNavCell: UIView!
    
    // Set UI colors to be used in playlist view
    // var borderColor : UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.0, alpha: 1.0)
    var blueHeaderColor = UIColor(red: 30/255, green: 128/255, blue: 240/255, alpha: 1.0)
    var blueHeaderColorTinted = UIColor(red: 30/255, green: 128/255, blue: 240/255, alpha: 0.9)
    var borderGray = UIColor(red: 188/255, green: 186/255, blue: 193/255, alpha: 1.0)
    
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
        "imageGroup" : ["02a_dumbbell_press.png", "02b_dumbbell_press.png"],
        "reps": "8",
        "sets": "3",
        "equipmentRequired" : "Dumbbells",
        "description" : "Warm up your muscles and get your heart rate up."]
    
    var bentOverRowDict = [
        "name" : "Bent over row", 
        "intensity" : "low", 
        "duration" : "4",
        "workoutGroup" : "Back",
        "muscleGroup" : "Upper Body",
        "imageGroup" : ["09a_bent_row.png", "09b_bent_row.png"],
        "reps": "10",
        "sets": "3",
        "equipmentRequired" : "Dumbbells",
        "description" : "Warm up your muscles and get your heart rate up."]
    
    var squatDict = [
        "name" : "Squats", 
        "intensity" : "low", 
        "duration" : "3",
        "workoutGroup" : "Quadriceps",
        "muscleGroup" : "Lower Body",
        "imageGroup" : ["", ""],
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
        "imageGroup" : ["", ""],
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
        "imageGroup" : ["", ""],
        "reps": "10",
        "sets": "3",
        "equipmentRequired" : "Dumbbells",
        "description" : "Warm up your muscles and get your heart rate up."]
    
    var tricepExtensionDict = [
        "name" : "Bent over tricep extension", 
        "intensity" : "low", 
        "duration" : "5",
        "workoutGroup" : "Triceps",
        "muscleGroup" : "Upper Body",
        "imageGroup" : ["", ""],
        "reps": "10",
        "sets": "3",
        "equipmentRequired" : "Dumbbells",
        "description" : "Warm up your muscles and get your heart rate up."]
    
    var legRaiseDict = [
        "name" : "Leg raises", 
        "intensity" : "low", 
        "duration" : "3",
        "workoutGroup" : "Abs",
        "muscleGroup" : "Core",
        "imageGroup" : ["", ""],
        "reps": "12",
        "sets": "4",
        "equipmentRequired" : "Pull-up Bar",
        "description" : "Warm up your muscles and get your heart rate up."]
    
    var expandedSection: Int! = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Style nav cells
        // muscleGroupNavCell.layer.borderColor = borderColor.CGColor
        // muscleGroupNavCell.layer.borderWidth = 1.0
        // timeNavCell.layer.borderColor = borderColor.CGColor
        // timeNavCell.layer.borderWidth = 1.0
        // locationNavCell.layer.borderColor = borderColor.CGColor
        // locationNavCell.layer.borderWidth = 1.0
        
        muscleGroupNavCell.layer.backgroundColor = blueHeaderColorTinted.CGColor
        
        // Setup initial tableView
        playlistTableView.delegate = self
        playlistTableView.dataSource = self
        // playlistTableView.registerClass(ExerciseCell.self, forCellReuseIdentifier: "cell")
        self.playlistTableView.reloadData()
        
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
        }
        
    }
    
    // View for the cell in the TableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Variables for debugging
        // println("section \(indexPath.section)")
        // println("row \(indexPath.row)")
        // println("combined \(indexPath.row + indexPath.section)")
        // println("exerciseDisplayCount \(exerciseDisplayCount)")
        
        exerciseDisplayCount = (indexPath.row + indexPath.section)
        
        // Solves for off by 1 error which causes crash on last exercise
        if exerciseDisplayCount >= (exerciseArray.count - 1) {
            exerciseDisplayCount = (exerciseArray.count - 1)
        }
        
        // If row is even (summary exercise cell)
        if indexPath.row % 2 == 0 {
            
            // Define exerciseCell
            let cell = playlistTableView.dequeueReusableCellWithIdentifier("ExerciseCell") as! ExerciseCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            // cell.contentView.layer.borderColor = borderColor.CGColor
            // cell.contentView.layer.borderWidth = 5.0
            
            self.playlistTableView.layer.masksToBounds = true
            
            // Sets the tableview cells to align margin left
            self.playlistTableView.separatorInset = UIEdgeInsetsZero
            self.playlistTableView.layoutMargins = UIEdgeInsetsZero
            cell.layoutMargins = UIEdgeInsetsZero
        
            var exerciseName = exerciseArray[exerciseDisplayCount]["name"] as? String
            var exerciseDuration = exerciseArray[exerciseDisplayCount]["duration"] as? String
            var exerciseIntensity = exerciseArray[exerciseDisplayCount]["intensity"] as? String
            var setCount = exerciseArray[exerciseDisplayCount]["sets"] as? String
            var repCount = exerciseArray[exerciseDisplayCount]["reps"] as? String
            var workoutGroup = exerciseArray[exerciseDisplayCount]["workoutGroup"] as? String
        
            // Populate exerciseCell
            cell.exerciseLabel.text = exerciseName!.capitalizedString
            cell.durationLabel.text = exerciseDuration!.capitalizedString
            cell.setRepLabel.text = (setCount! + " x " + repCount!)
            cell.workoutGroupLabel.text = workoutGroup!.capitalizedString
            
            // Passes the exerciseDisplayCount into cell so that we can delete it
            cell.exerciseLabel.tag = indexPath.section
        
            // Hide icons and full-screen images on initial view load
            cell.laterIconImageView.alpha = 0
            cell.archiveIconImageView.alpha = 0
            cell.delegate = self
            
            return cell

        // If row is odd (detailed exercise cell)
        } else {
            
            // Define exerciseDetailCell
            let cell = playlistTableView.dequeueReusableCellWithIdentifier("ExerciseDetailCell") as! ExerciseDetailCell
            var exerciseDescription = exerciseArray[exerciseDisplayCount]["description"] as? String
            var exerciseImageArray = exerciseArray[exerciseDisplayCount]["imageGroup"] as! [String]
            
            var exerciseStartingImagePath = String(exerciseImageArray[0])
            var exerciseEndingImagePath = String(exerciseImageArray[1])
            
            // 02a_dumbbell_press.png
            // 09a_bent_row.png
            
            if exerciseEndingImagePath != "" {
                cell.exerciseImageView.image = UIImage(named: exerciseStartingImagePath)
                println(exerciseStartingImagePath)
            }
            
            cell.exerciseDescriptionTextField.textAlignment = .Center
            cell.exerciseDescriptionTextField.text = exerciseDescription
            cell.clipsToBounds = true
            
            cell.favoriteViewContainer.layer.borderColor = borderGray.CGColor
            cell.favoriteViewContainer.layer.borderWidth = 0.5;
            
            // Keeps cell flush with left margins
            cell.layoutMargins = UIEdgeInsetsZero
            
            // Prevents cell from highlighting
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if expandedSection == indexPath.section {
                // If you tap on the section that's already expanded, you should collapse it
                expandedSection = -1
            } else {
                expandedSection = indexPath.section
            }
            
            // This causes the row height change to be animated
            tableView.beginUpdates()
            tableView.endUpdates()
            tableView.scrollToNearestSelectedRowAtScrollPosition(UITableViewScrollPosition.Top, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var exerciseHeight = CGFloat(86)
        if indexPath.row == 0 {
            return exerciseHeight
        } else {
            if indexPath.section == expandedSection {
                // Calculate the height of the detail view so that there is room for an exercise header above and below the detail view.
                var height = tableView.frame.size.height - 2 * exerciseHeight
                return height
            } else {
                return 0
            }
        }
    }
    
    func exerciseDeleted(exerciseIndex: Int) {
        exerciseArray.removeAtIndex(exerciseIndex)
        playlistTableView.beginUpdates()
        playlistTableView.deleteSections(NSIndexSet(index:exerciseIndex), withRowAnimation: UITableViewRowAnimation.Fade)
        playlistTableView.endUpdates()
        playlistTableView.reloadData()
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
    
    // Sets the style for that sweet sweet navigationBar
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Monday's Playlist"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "SFUIText-Bold", size: 18)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = blueHeaderColor
        self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
    }
    
    // Sets status bar style to either light or dark (default)
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
