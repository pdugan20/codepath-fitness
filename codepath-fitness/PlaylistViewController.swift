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

    // Declare individual exercise dictionaries
    var pullUpDict = [
        "name" : "Pull-ups", 
        "intensity" : "low", 
        "duration" : "5", 
        "description" : "Pull yourself up over the bar!"]
    var sitUpDict = [
        "name" : "Sit-ups", 
        "intensity" : "medium", 
        "duration" : "3", 
        "description" : "Bend your knees and sit up!"]
    var burpeeDict = [
        "name" : "Burpees",
        "intensity" : "high",
        "duration" : "5",
        "description" : "Jump up then do a push up and don't be a wimp."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup initial tableView
        playlistTableView.delegate = self
        playlistTableView.dataSource = self
        
        // API url
        var clientId = "BpmHUyPDIDaWYqoSL5rTcj27ryCj9N29"
        var fitnessApiUrl = NSURL(string: "https://www.kimonolabs.com/api/bfcfz33q?apikey=\(clientId)")!
        
        // Add exercises to an array
        exerciseArray = [pullUpDict, sitUpDict, burpeeDict]
        
        // Networking request for JSON feed
        var request = NSURLRequest(URL: fitnessApiUrl)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
            // println(responseDictionary)
            // self.exerciseArray = responseDictionary["results"] as! NSArray
            // println(self.exerciseArray)
            // self.playlistTableView.reloadData()
        }
        
    }
    
    // View for the cell in the TableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Define exerciseCell
        var cell = playlistTableView.dequeueReusableCellWithIdentifier("ExerciseCell") as! ExerciseCell
        
        // var exercise = exerciseArray[indexPath.row] as! NSDictionary
        // var exerciseName = exercise.valueForKeyPath("Collection1.Exercise Name.text") as? String
        
        // Populate exerciseCell
        cell.exerciseLabel.text = exerciseArray[indexPath.row]["name"] as? String
        cell.durationLabel.text = exerciseArray[indexPath.row]["duration"] as? String
        cell.intensityLabel.text = exerciseArray[indexPath.row]["intensity"] as? String
        
        // Hide icons and full-screen images on initial view load
        cell.laterIconImageView.alpha = 0
        cell.archiveIconImageView.alpha = 0
        
        return cell
    }
    
    // How many rows in TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseArray.count
        // return 20
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
