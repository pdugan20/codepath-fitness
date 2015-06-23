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
    
    // Declare parent exercise arrays
    // var exerciseArray: [AnyObject] = []
    var exerciseArray: NSMutableArray = []
    
    // var exerciseArray2: [AnyObject] = []
    var exerciseArray2: NSMutableArray = []
    
    // Declare master of displayed exercises
    var exerciseDisplayCount: Int!

    // Declare cells for each top-level summary item
    @IBOutlet weak var muscleGroupNavCell: UIView!
    
    // Initalization for moving cells
    var sourceIndexPath: NSIndexPath? = nil
    var snapshot: UIView? = nil
    
    // Set UI colors to be used in playlist view
    // var borderColor : UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.0, alpha: 1.0)
    var blueHeaderColor = UIColor(red: 30/255, green: 128/255, blue: 240/255, alpha: 1.0)
    var blueHeaderColorTinted = UIColor(red: 30/255, green: 128/255, blue: 240/255, alpha: 0.9)
    var borderGray = UIColor(red: 188/255, green: 186/255, blue: 193/255, alpha: 1.0)
    
    // Begin Workout #1
    
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
        "imageGroup" : ["02a_dumbbell_bench_press.png", "02b_dumbbell_bench_press.png"],
        "reps": "8",
        "sets": "3",
        "equipmentRequired" : "Dumbbells",
        "description" : "Raise and lower weights slowly, bringing arm to a 45 degree angle."]
    
    var bentOverRowDict = [
        "name" : "Bent over row", 
        "intensity" : "low", 
        "duration" : "4",
        "workoutGroup" : "Back",
        "muscleGroup" : "Upper Body",
        "imageGroup" : ["09a_bent_over_row.png", "09b_bent_over_row.png"],
        "reps": "10",
        "sets": "3",
        "equipmentRequired" : "Dumbbells",
        "description" : "Keep your back straight and head up, lifting weights towards your rib cage."]
    
    var squatDict = [
        "name" : "Bodyweight squat", 
        "intensity" : "low", 
        "duration" : "3",
        "workoutGroup" : "Quadriceps",
        "muscleGroup" : "Lower Body",
        "imageGroup" : ["20a_squat.png", "20b_squat.png"],
        "reps": "20",
        "sets": "3",
        "equipmentRequired" : "None",
        "description" : "Feet shoulder width apart. Lower slowly, keeping back straight up and knees out."]
    
    var stepUpDict = [
        "name" : "Step up with curl", 
        "intensity" : "low", 
        "duration" : "6",
        "workoutGroup" : "Legs, Biceps",
        "muscleGroup" : "Full Body",
        "imageGroup" : ["22a_step_up_with_curl.png", "22b_step_up_with_curl.png"],
        "reps": "10",
        "sets": "2",
        "equipmentRequired" : "Dumbbells",
        "description" : "Keep your back straight and head up, lifting weights towards your rib cage."]
    
    var standingDumbbellDict = [
        "name" : "Standing dumbbell shoulder press", 
        "intensity" : "low", 
        "duration" : "4",
        "workoutGroup" : "Shoulders",
        "muscleGroup" : "Upper Body",
        "imageGroup" : ["17a_standing_dumbbell_shoulder_press.png", "17b_standing_dumbbell_shoulder_press.png"],
        "reps": "10",
        "sets": "3",
        "equipmentRequired" : "Dumbbells",
        "description" : "Start with dumbbells at shoulder height and slowly raise until arms are fully extended."]
    
    var tricepExtensionDict = [
        "name" : "Bent over tricep kickback", 
        "intensity" : "low", 
        "duration" : "5",
        "workoutGroup" : "Triceps",
        "muscleGroup" : "Upper Body",
        "imageGroup" : ["10a_bent_over_tricep_extension.png", "10b_bent_over_tricep_extension.png"],
        "reps": "10",
        "sets": "3",
        "equipmentRequired" : "Dumbbells",
        "description" : "Lean over with torso parallel to the floor, fully extend at the elbow."]
    
    var legRaiseDict = [
        "name" : "Hanging leg raises", 
        "intensity" : "low", 
        "duration" : "3",
        "workoutGroup" : "Abs",
        "muscleGroup" : "Core",
        "imageGroup" : ["23a_hanging_leg_raises.png", "23a_hanging_leg_raises.png"],
        "reps": "12",
        "sets": "4",
        "equipmentRequired" : "Pull-up Bar",
        "description" : "Slowly raise legs to a 90-degree angle, holding for 2 seconds. Don't swing!"]
    
    // Begin Workout #2
    
    var burpeesDict = [
        "name" : "Burpees",
        "intensity" : "low",
        "duration" : "3",
        "workoutGroup" : "Legs + Triceps",
        "muscleGroup" : "Full Body",
        "imageGroup" : ["", ""],
        "reps": "15",
        "sets": "3",
        "equipmentRequired" : "None",
        "description" : "Stand, drop to pushup position, jump your feet under you, then jump up. Repeat."]
    
    var medBallDumbbellPressDict = [
        "name" : "Swiss Ball Dumbbell Press",
        "intensity" : "low",
        "duration" : "5",
        "workoutGroup" : "Chest",
        "muscleGroup" : "Upper Body",
        "imageGroup" : ["", ""],
        "reps": "10",
        "sets": "3",
        "equipmentRequired" : "Dumbbells",
        "description" : "Raise your hips and keep your feet wide for balance."]
    
    var flyDict = [
        "name" : "Dumbbell Fly",
        "intensity" : "low",
        "duration" : "5",
        "workoutGroup" : "Chest",
        "muscleGroup" : "Upper Body",
        "imageGroup" : ["", ""],
        "reps": "18",
        "sets": "2",
        "equipmentRequired" : "Dumbbells",
        "description" : "Slowly lower weights until your tricep is parallel with the floor."]
    
    var plankRowDict = [
        "name" : "Plank Row",
        "intensity" : "low",
        "duration" : "5",
        "workoutGroup" : "Back",
        "muscleGroup" : "Upper Body",
        "imageGroup" : ["", ""],
        "reps": "10",
        "sets": "3",
        "equipmentRequired" : "Dumbbells",
        "description" : "Retract each shoulder blade, pulling the weight until your hand is alongside your ribs."]
    
    var bentReverseFlyDict = [
        "name" : "Bent over reverse fly",
        "intensity" : "low",
        "duration" : "4",
        "workoutGroup" : "Back",
        "muscleGroup" : "Upper Body",
        "imageGroup" : ["", ""],
        "reps": "12",
        "sets": "3",
        "equipmentRequired" : "Dumbbells",
        "description" : "Use light weights, squeeze shoulder blades together"]
    
    var lateralRaiseDict = [
        "name" : "Laying lateral raise",
        "intensity" : "low",
        "duration" : "4",
        "workoutGroup" : "Shoulders",
        "muscleGroup" : "Upper Body",
        "imageGroup" : ["", ""],
        "reps": "10",
        "sets": "3",
        "equipmentRequired" : "Dumbbells",
        "description" : "Raise your, keeping it perpendicular to the body. Hold at the top for bonus pump."]
    
    var chinUpDict = [
        "name" : "Chin up",
        "intensity" : "low",
        "duration" : "4",
        "workoutGroup" : "Biceps",
        "muscleGroup" : "Upper Body",
        "imageGroup" : ["", ""],
        "reps": "10",
        "sets": "4",
        "equipmentRequired" : "Pull-up bar",
        "description" : "Grip bar narrower than shoulder width, keeping torso straight throughout the movement"]
    
    var dipsDict = [
        "name" : "Dips",
        "intensity" : "low",
        "duration" : "4",
        "workoutGroup" : "Triceps",
        "muscleGroup" : "Upper Body",
        "imageGroup" : ["", ""],
        "reps": "12",
        "sets": "3",
        "equipmentRequired" : "None",
        "description" : "Lower until tricepts are parrallel to the ground, keep it nice and slow."]
    
    var standingTricepExtensionDict = [
        "name" : "Standing overhead tricep extension",
        "intensity" : "low",
        "duration" : "4",
        "workoutGroup" : "Triceps",
        "muscleGroup" : "Upper Body",
        "imageGroup" : ["", ""],
        "reps": "10",
        "sets": "3",
        "equipmentRequired" : "Dumbbells",
        "description" : "Slight knee bend, keeping back straight. Hold at full extension to feel the power!"]
    
    var expandedSection: Int! = -1
    
    // Instantiate long press gesture
    let longPress: UILongPressGestureRecognizer = {
        let recognizer = UILongPressGestureRecognizer()
        return recognizer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        longPress.addTarget(self, action: "longPressGestureRecognized:")
        playlistTableView.addGestureRecognizer(longPress)
        
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
        
        // Add exercises to Workout #1
        exerciseArray = [dumbellPressDict, bentOverRowDict, squatDict, stepUpDict, standingDumbbellDict, tricepExtensionDict, legRaiseDict]
        
        // Add exercises to Workout #2
        exerciseArray2 = [burpeesDict, medBallDumbbellPressDict, flyDict, plankRowDict, bentReverseFlyDict, lateralRaiseDict, chinUpDict, dipsDict, standingTricepExtensionDict]
        
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
        // if exerciseDisplayCount >= (exerciseArray.count - 1) {
        //    exerciseDisplayCount = (exerciseArray.count - 1)
        // }
        
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
            
            // Offset exerciseDisplayCount
            exerciseDisplayCount = exerciseDisplayCount - 1
            
            // Define exerciseDetailCell
            let cell = playlistTableView.dequeueReusableCellWithIdentifier("ExerciseDetailCell") as! ExerciseDetailCell
            var exerciseDescription = exerciseArray[exerciseDisplayCount]["description"] as? String
            var exerciseImageArray = exerciseArray[exerciseDisplayCount]["imageGroup"] as! [String]
            
            var exerciseStartingImagePath = String(exerciseImageArray[0])
            var exerciseEndingImagePath = String(exerciseImageArray[1])
            
            // Loads exercise starting image
            if exerciseStartingImagePath != "" {
                cell.exerciseImageView.image = UIImage(named: exerciseStartingImagePath)
            }
            
            // Loads exercise complete image
            if exerciseEndingImagePath != "" {
                cell.exerciseCompleteImageView.image = UIImage(named: exerciseEndingImagePath)
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
            
            cell.exerciseCompleteImageView.alpha = 0
            cell.exerciseImageView.alpha = 1
            
            UIView.animateWithDuration(2, delay:0, options:UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat, animations: {
                cell.exerciseCompleteImageView.alpha = 1
                cell.exerciseImageView.alpha = 0
                }, completion: { finished in
            })
            
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
        // exerciseArray.removeAtIndex(exerciseIndex)
        exerciseArray.removeObjectAtIndex(exerciseIndex)
        
        playlistTableView.beginUpdates()
        playlistTableView.deleteSections(NSIndexSet(index:exerciseIndex), withRowAnimation: UITableViewRowAnimation.Fade)
        playlistTableView.endUpdates()
        playlistTableView.reloadData()
    }
    
    func exerciseSwapped(exerciseIndex: Int) {
        // Deletes current exercise from array
        // exerciseArray.removeAtIndex(exerciseIndex)
        exerciseArray.removeObjectAtIndex(exerciseIndex)
        
        // Adds new exercise into previous position
        // exerciseArray.insert(exerciseArray2[exerciseIndex], atIndex: exerciseIndex)
        exerciseArray.insertObject(exerciseArray2[exerciseIndex], atIndex: exerciseIndex)
        
        playlistTableView.beginUpdates()
        // playlistTableView.deleteSections(NSIndexSet(index:exerciseIndex), withRowAnimation: UITableViewRowAnimation.Fade)
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
    
    func longPressGestureRecognized(gesture: UILongPressGestureRecognizer) {
        let state: UIGestureRecognizerState = gesture.state
        let location: CGPoint = gesture.locationInView(playlistTableView)
        let indexPath: NSIndexPath? = playlistTableView.indexPathForRowAtPoint(location)
        
        if indexPath == nil {
            return
        }
        
        switch (state) {
            
        case UIGestureRecognizerState.Began:
            sourceIndexPath = indexPath;
            let cell = playlistTableView.cellForRowAtIndexPath(indexPath!)!
            snapshot = customSnapshotFromView(cell)
            
            var center = cell.center
            snapshot?.center = center
            snapshot?.alpha = 0.0
            playlistTableView.addSubview(snapshot!)
            
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                center.y = location.y
                self.snapshot?.center = center
                self.snapshot?.transform = CGAffineTransformMakeScale(1.05, 1.05)
                self.snapshot?.alpha = 0.98
                cell.alpha = 0.0
            })
            
        case UIGestureRecognizerState.Changed:
            var center: CGPoint = snapshot!.center
            center.y = location.y
            snapshot?.center = center
            
            // Is destination valid and is it different from source?
            if indexPath != sourceIndexPath {
                
                println(indexPath!.section)
                println(sourceIndexPath!.section)
                
                // update data source.
                exerciseArray.exchangeObjectAtIndex(indexPath!.section, withObjectAtIndex: sourceIndexPath!.section)
                        
                // move the rows
                // playlistTableView.moveRowAtIndexPath(sourceIndexPath!, toIndexPath: indexPath!)
                playlistTableView.moveSection(indexPath!.section, toSection: sourceIndexPath!.section)
                
                // update source so it is in sync with UI changes.
                sourceIndexPath = indexPath;
            }
            
        default:
            // Clean up.
            let cell = playlistTableView.cellForRowAtIndexPath(indexPath!)!
            cell.alpha = 0.0
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.snapshot?.center = cell.center
                self.snapshot?.transform = CGAffineTransformIdentity
                self.snapshot?.alpha = 0.0
                // Undo fade out.
                cell.alpha = 1.0
                }, completion: { (finished) in
                    self.sourceIndexPath = nil
                    self.snapshot?.removeFromSuperview()
                    self.snapshot = nil;
            })
            break
        }
    }
    
    func customSnapshotFromView(inputView: UIView) -> UIView {
        
        // Make an image from the input view.
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0)
        inputView.layer.renderInContext(UIGraphicsGetCurrentContext())
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        // Create an image view.
        let snapshot = UIImageView(image: image)
        snapshot.layer.masksToBounds = false
        snapshot.layer.cornerRadius = 0.0
        snapshot.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
        snapshot.layer.shadowRadius = 5.0
        snapshot.layer.shadowOpacity = 0.4
        
        return snapshot
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
