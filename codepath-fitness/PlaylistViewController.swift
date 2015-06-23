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
    var exerciseArray: NSMutableArray = []
    var exerciseArray2: NSMutableArray = []
    
    // Declare master of displayed exercises
    var exerciseDisplayCount: Int!
    var expandedSection: Int! = -1

    // Declare cells for each top-level summary item
    @IBOutlet weak var muscleGroupNavCell: UIView!
    
    // Initalization for moving cells
    var sourceIndexPath: NSIndexPath? = nil
    var snapshot: UIView? = nil
    
    // Set UI colors to be used in playlist view
    var blueHeaderColor = UIColor(red: 30/255, green: 128/255, blue: 240/255, alpha: 1.0)
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
        "imageGroup" : ["21a_burpee.png", "21b_burpee.png"],
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
        "imageGroup" : ["01a_medicine_dumbbell.png", "01b_medicine_dumbbell.png"],
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
        "imageGroup" : ["05a_fly.png", "05b_fly.png"],
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
        "imageGroup" : ["07a_plank_row.png", "07b_plank_row.png"],
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
        "imageGroup" : ["08a_bent_reverse_fly.png", "08b_bent_reverse_fly.png"],
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
        "imageGroup" : ["15a_laying_lateral raise.png", "15b_laying_lateral raise.png"],
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
        "imageGroup" : ["13a_chin_ups.png", "13b_chin_ups.png"],
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
        "imageGroup" : ["12a_dips.png", "12b_dips.png"],
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
        "imageGroup" : ["11a_standing_tricep extension.png", "11b_standing_tricep extension.png"],
        "reps": "10",
        "sets": "3",
        "equipmentRequired" : "Dumbbells",
        "description" : "Slight knee bend, keeping back straight. Hold at full extension to feel the power!"]
    
    // Instantiate long press gesture
    let longPress: UILongPressGestureRecognizer = {
        let recognizer = UILongPressGestureRecognizer()
        return recognizer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup initial tableView
        playlistTableView.delegate = self
        playlistTableView.dataSource = self
        self.playlistTableView.reloadData()

        // Adds long-press gesture recgonizer to each cell
        longPress.addTarget(self, action: "longPressGestureRecognized:")
        playlistTableView.addGestureRecognizer(longPress)
        
        // Add exercises to Workout #1
        exerciseArray = [dumbellPressDict, bentOverRowDict, squatDict, stepUpDict, standingDumbbellDict, tricepExtensionDict, legRaiseDict]
        
        // Add exercises to Workout #2
        exerciseArray2 = [burpeesDict, medBallDumbbellPressDict, flyDict, plankRowDict, bentReverseFlyDict, lateralRaiseDict, chinUpDict, dipsDict, standingTricepExtensionDict]
        
    }
    
    // View for the cell in the TableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Row + section provides iterator
        exerciseDisplayCount = (indexPath.row + indexPath.section)
        
        // If row is even (implements collapsed exercise cell)
        if indexPath.row % 2 == 0 {
            
            // Define exerciseCell
            let cell = playlistTableView.dequeueReusableCellWithIdentifier("ExerciseCell") as! ExerciseCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            // Sets the tableview cells to align margin left
            self.playlistTableView.layer.masksToBounds = true
            self.playlistTableView.separatorInset = UIEdgeInsetsZero
            self.playlistTableView.layoutMargins = UIEdgeInsetsZero
            cell.layoutMargins = UIEdgeInsetsZero
        
            // Sets all variables pulled from exerciseArray
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

        // If row is odd (implements expanded exercise cell)
        } else {
            
            // Offset exerciseDisplayCount
            exerciseDisplayCount = exerciseDisplayCount - 1
            
            // Define exerciseDetailCell
            let cell = playlistTableView.dequeueReusableCellWithIdentifier("ExerciseDetailCell") as! ExerciseDetailCell
            
            // Sets all variables pulled from exerciseArray
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
            
            // Adds additional UI polish to expanded cell
            cell.exerciseDescriptionTextField.textAlignment = .Center
            cell.exerciseDescriptionTextField.text = exerciseDescription
            cell.favoriteViewContainer.layer.borderColor = borderGray.CGColor
            cell.favoriteViewContainer.layer.borderWidth = 0.5;
            
            // Keeps cell flush with left margins
            cell.layoutMargins = UIEdgeInsetsZero
            cell.clipsToBounds = true
            
            // Prevents cell from highlighting
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            // Sets transparency of both exercise images
            cell.exerciseCompleteImageView.alpha = 0
            cell.exerciseImageView.alpha = 1
            
            // Handles looping animation for both exercise images
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
    
    // Handles expansion of second exercise cell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Implements expansion functionality
        if indexPath.row == 0 {
            if expandedSection == indexPath.section {
                // Collapse already expanded section onTap
                expandedSection = -1
            } else {
                expandedSection = indexPath.section
            }
            // Animates row height of expanding cell
            playlistTableView.beginUpdates()
            playlistTableView.endUpdates()
            playlistTableView.scrollToNearestSelectedRowAtScrollPosition(UITableViewScrollPosition.Top, animated: true)
        }
    }
    
    // Handles expansion of second exercise cell
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        // Sets height of expanded exercise cell
        var exerciseHeight = CGFloat(86)
        // Implements expansion functionality
        if indexPath.row == 0 {
            return exerciseHeight
        } else {
            if indexPath.section == expandedSection {
                // Calculates the height of the detail view, makes room for exercise header
                var height = playlistTableView.frame.size.height - 2 * exerciseHeight
                return height
            } else {
                return 0
            }
        }
    }
    
    // Deletes exercise cell when swiping left
    func exerciseDeleted(exerciseIndex: Int) {
        // Deletes selected exercise from current playlist
        exerciseArray.removeObjectAtIndex(exerciseIndex)
        
        // Updates current tableview
        playlistTableView.beginUpdates()
        playlistTableView.deleteSections(NSIndexSet(index:exerciseIndex), withRowAnimation: UITableViewRowAnimation.Fade)
        playlistTableView.endUpdates()
        
        // Adds all remaining sections to an indexSet
        var indexSet = NSMutableIndexSet()
        for (var i = 0; i < exerciseArray.count ; i++ ) {
            indexSet.addIndex(i)
        }
        
        // Animates all remaining sections within index
        playlistTableView.reloadSections(indexSet, withRowAnimation: UITableViewRowAnimation.Fade)
        
    }
    
    // Swaps exercise cell when swiping right
    func exerciseSwapped(exerciseIndex: Int) {
        // Deletes selected exercise from current playlist
        exerciseArray.removeObjectAtIndex(exerciseIndex)
        
        // Swaps in first exercise from second playlist
        exerciseArray.insertObject(exerciseArray2[0], atIndex: exerciseIndex)
        
        // Deletes first exercise from second playlist
        exerciseArray2.removeObjectAtIndex(0)
        
        // Adds all remaining sections to an indexSet
        var indexSet = NSMutableIndexSet()
        for (var i = 0; i < exerciseArray.count ; i++ ) {
            indexSet.addIndex(i)
        }
        
        // Animates all remaining sections within index
        playlistTableView.reloadSections(indexSet, withRowAnimation: UITableViewRowAnimation.Fade)
        
    }
    
    // Sets the style for navigation bar
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
    
    // Handles longpress reordering of exericse cells
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
            var center = cell.center
            
            snapshot = customSnapshotFromView(cell)
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
            
            // Is destination valid and is different from source
            if indexPath != sourceIndexPath {
                
                // Updates exerciseArray
                exerciseArray.exchangeObjectAtIndex(indexPath!.section, withObjectAtIndex: sourceIndexPath!.section)
                        
                // Move the exercise summary cell
                playlistTableView.moveSection(indexPath!.section, toSection: sourceIndexPath!.section)
                
                // Update source so it is in sync with UI changes
                sourceIndexPath = indexPath;
            }
            
        default:
            let cell = playlistTableView.cellForRowAtIndexPath(indexPath!)!
            cell.alpha = 0.0
            
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.snapshot?.center = cell.center
                self.snapshot?.transform = CGAffineTransformIdentity
                self.snapshot?.alpha = 0.0
                
                // Undo fade out
                cell.alpha = 1.0
                }, completion: { (finished) in
                    self.sourceIndexPath = nil
                    self.snapshot?.removeFromSuperview()
                    self.snapshot = nil;
            })
            break
        }
    }
    
    // Generates snapshot of exericse cell while moving
    func customSnapshotFromView(inputView: UIView) -> UIView {
        
        // Make an image from the input view
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0)
        inputView.layer.renderInContext(UIGraphicsGetCurrentContext())
        
        // Defines image inside of table view
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        // Create an image view
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
