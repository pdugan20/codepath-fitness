//
//  SettingsViewController.swift
//  codepath-fitness
//
//  Created by Patrick on 6/10/15.
//  Copyright (c) 2015 PPK Inc. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var header1View: UIView!
    @IBOutlet weak var durationButton: UIButton!
    @IBOutlet weak var header1option1: UIView!
    @IBOutlet weak var header1option2: UIView!
    @IBOutlet weak var header1option3: UIView!
    @IBOutlet weak var header1option4: UIView!
    @IBOutlet weak var header1option1Button: UIButton!
    @IBOutlet weak var header1option2Button: UIButton!
    @IBOutlet weak var header1option3Button: UIButton!
    @IBOutlet weak var header1option4Button: UIButton!
    
    var header1ViewOriginalCenter: CGPoint!
    var header1option1Hidden: CGPoint!
    var header1option1Shown: CGPoint!
    var header1option2Hidden: CGPoint!
    var header1option2Shown: CGPoint!
    var header1option3Hidden: CGPoint!
    var header1option3Shown: CGPoint!
    var header1option4Hidden: CGPoint!
    var header1option4Shown: CGPoint!
    var durationPreference: String!
    
    var header1optionsShown: Bool!
    
    @IBOutlet weak var header2View: UIView!
    @IBOutlet weak var workoutTypeButton: UIButton!
    @IBOutlet weak var header2option1: UIView!
    @IBOutlet weak var header2option2: UIView!
    @IBOutlet weak var header2option3: UIView!
    @IBOutlet weak var header2option1Button: UIButton!
    @IBOutlet weak var header2option2Button: UIButton!
    @IBOutlet weak var header2option3Button: UIButton!
    
    var header2ViewOriginalCenter: CGPoint!
    var header2ViewExpandPosition: CGPoint!
    var header2BelowExpandedHeader1: CGPoint!
    var header2option1Hidden: CGPoint!
    var header2option1Shown: CGPoint!
    var header2option2Hidden: CGPoint!
    var header2option2Shown: CGPoint!
    var header2option3Hidden: CGPoint!
    var header2option3Shown: CGPoint!
    
    var header2optionsShown: Bool!
    
    @IBOutlet weak var header3View: UIView!
    @IBOutlet weak var locationButton: UIButton!
    
    var header3ViewOriginalCenter: CGPoint!
    var header3ViewExpandPosition: CGPoint!
    var header3BelowExpandedOption1Position: CGPoint!
    var header3BelowExpandedOption2Position: CGPoint!
    
    @IBOutlet weak var header3option1: UIView!
    @IBOutlet weak var header3option2: UIView!
    @IBOutlet weak var header3option1Button: UIButton!
    @IBOutlet weak var header3option2Button: UIButton!
    
    var durationSelection: String!
    var typeSelection: String!
    var locationSelection: String!
    
    var header3option1Shown: CGPoint!
    var header3option1Hidden: CGPoint!
    var header3option2Shown: CGPoint!
    var header3option2Hidden: CGPoint!
    
    var header3optionsShown: Bool!
    
    @IBOutlet weak var generateWorkoutButton: UIButton!
    var generateWorkoutButtonHidden: CGPoint!
    var generateWorkoutButtonShown: CGPoint!
    @IBOutlet weak var buttonCoverView: UIView!
    
    var header2HasBeenPresented: Bool!
    var header3HasBeenPresented: Bool!
    
    @IBOutlet weak var profileButton: UIButton!
    
    var onNavigationButtonPressed:((Void)->Void)!
    
    // Set UI colors to be used in playlist view
    // var borderColor : UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.0, alpha: 1.0)
    var blueHeaderColor = UIColor(red: 30/255, green: 128/255, blue: 240/255, alpha: 1.0)
    var blueHeaderColorTinted = UIColor(red: 30/255, green: 128/255, blue: 240/255, alpha: 0.9)
    var borderGray = UIColor(red: 188/255, green: 186/255, blue: 193/255, alpha: 1.0)
    var listItemColor = UIColor(red: 235/255, green: 241/255, blue: 244/255, alpha: 1.0)
    var descriptionColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
    var descriptionSelectedColor = UIColor.whiteColor()
    
    var listItemSelectedColor = UIColor(red: 33/255, green: 140/255, blue: 190/255, alpha: 1.0)
    var option1ItemSelectedColor = UIColor(red: 33/255, green: 140/255, blue: 190/255, alpha: 0.9)
    var option2ItemSelectedColor = UIColor(red: 33/255, green: 140/255, blue: 190/255, alpha: 0.7)
    var option3ItemSelectedColor = UIColor(red: 33/255, green: 140/255, blue: 190/255, alpha: 0.5)
    var option4ItemSelectedColor = UIColor(red: 33/255, green: 140/255, blue: 190/255, alpha: 0.3)





    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        header1View.layer.backgroundColor = listItemSelectedColor.CGColor
        durationButton.setTitleColor(descriptionSelectedColor, forState: UIControlState.Normal)

        header1ViewOriginalCenter = header1View.center
        
        // For all options, shown = the final location of the button when exposed, hidden = animating from behind the header
        header1option1Shown = header1option1.center
        header1option1Hidden = CGPoint(x: header1View.center.x, y: header1View.center.y)
        header1option1.center = header1option1Hidden
        
        header1option2Shown = header1option2.center
        header1option2Hidden = CGPoint(x: header1View.center.x, y: header1View.center.y)
        header1option2.center = header1option2Hidden
        
        
        header1option3Shown = header1option3.center
        header1option3Hidden = CGPoint(x: header1View.center.x, y: header1View.center.y)
        header1option3.center = header1option3Hidden
        
        
        header1option4Shown = header1option4.center
        header1option4Hidden = CGPoint(x: header1View.center.x, y: header1View.center.y)
        header1option4.center = header1option4Hidden
        
        
        // These allow us to know when the section is expanded or collapsed, so we can toggle
        header1optionsShown = false
        header2optionsShown = false
        header3optionsShown = false
        
        header2option1.alpha = 0
        header2option2.alpha = 0
        header2option3.alpha = 0
        
        header2ViewOriginalCenter = header2View.center
        header2ViewExpandPosition = CGPoint(x: header2View.center.x, y: header1View.center.y + 72)
        header2BelowExpandedHeader1 = CGPoint(x: header2View.center.x, y: header1option4.center.y + 72)
        
        header2option1Shown = header2option1.center
        header2option1Hidden = header2ViewExpandPosition
        header2option1.center = header2option1Hidden
        
        header2option2Shown = header2option2.center
        header2option2Hidden = header2ViewExpandPosition
        header2option2.center = header2option2Hidden
        
        header2option3Shown = header2option3.center
        header2option3Hidden = header2ViewExpandPosition
        header2option3.center = header2option3Hidden
        
        header3ViewOriginalCenter = header3View.center
        header3ViewExpandPosition = CGPoint(x: header3View.center.x, y: header2ViewExpandPosition.y + 72)
        header3BelowExpandedOption1Position = CGPoint(x: header3View.center.x, y: header2BelowExpandedHeader1.y + 72)
        header3BelowExpandedOption2Position = CGPoint(x: header3View.center.x, y: header2option3.center.y + 72)
        
        header3option1Shown = header3option1.center
        header3option1Hidden = header3ViewExpandPosition
        header3option1.center = header3option1Hidden
        
        header3option2Shown = header3option2.center
        header3option2Hidden = header3ViewExpandPosition
        header3option2.center = header3option2Hidden
        
        header3option1.alpha = 0
        header3option2.alpha = 0
        
        // Set the background colors for option cells
        self.header1option1.backgroundColor = self.option1ItemSelectedColor
        self.header1option2.backgroundColor = self.option2ItemSelectedColor
        self.header1option3.backgroundColor = self.option3ItemSelectedColor
        self.header1option4.backgroundColor = self.option4ItemSelectedColor
        
        self.header2option1.backgroundColor = self.option1ItemSelectedColor
        self.header2option2.backgroundColor = self.option2ItemSelectedColor
        self.header2option3.backgroundColor = self.option3ItemSelectedColor
        
        self.header3option1.backgroundColor = self.option1ItemSelectedColor
        self.header3option2.backgroundColor = self.option2ItemSelectedColor

        
        // After the user has made all 3 required selections, the 'Generate Workout' button is exposed
        generateWorkoutButtonShown = generateWorkoutButton.center
        generateWorkoutButtonHidden = CGPoint(x: generateWorkoutButton.center.x, y: generateWorkoutButtonShown.y + 400)
        generateWorkoutButton.center = generateWorkoutButtonHidden
        buttonCoverView.alpha = 0
        
        // Used to determine how the animations should behave between the first flow (false) and after exposing sections (true)
        header2HasBeenPresented = false
        header3HasBeenPresented = false
        
        durationButton.setTitle(("Duration"), forState: .Normal)
        workoutTypeButton.setTitle(("Workout Type"), forState: .Normal)
        locationButton.setTitle(("Location"), forState: .Normal)
        
        profileButton.selected = false
        
        // Animates in the initial set of options to choose from
        UIView.animateWithDuration(0.3, delay: 0.3, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.header1option1.center = self.header1option1Shown
            self.header1option2.center = self.header1option2Shown
            self.header1option3.center = self.header1option3Shown
            self.header1option4.center = self.header1option4Shown
            
            }, completion: nil)
        self.header1optionsShown = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onHeader1Tap(sender: AnyObject) {
        
        // This first if statement deterimes if the header is already expanded or collapsed
        if header1optionsShown == false {
            
            println("i'm tapping header 1")
            
            durationButton.setTitle(("Duration"), forState: .Normal)
            
            // This if / else-if rule set alters the behavior depending on if Headers 2 and 3 have been exposed yet
            if header2HasBeenPresented == true && header3HasBeenPresented == false {
                
                header1optionsShow()
                header2optionsHide()
                header3optionsHide()
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.header2View.center = CGPoint(x: self.header2View.center.x, y: self.header1option4.center.y + 72)
                    }, completion: nil)
                
            } else if header2HasBeenPresented == true && header3HasBeenPresented == true {
                
                header1optionsShow()
                header2optionsHide()
                header3optionsHide()
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.header2View.center = CGPoint(x: self.header2View.center.x, y: self.header1option4.center.y + 72)
                    self.header3View.center = CGPoint(x: self.header3View.center.x, y: self.header1option4.center.y + 144)
                    self.buttonCoverView.alpha = 0.95
                    }, completion: nil)
            }
            
        } else if header1optionsShown == true {
            
            self.durationButton.setTitle("\(sender.titleLabel!!.text!)", forState: .Normal)
            
            if header2HasBeenPresented == true && header3HasBeenPresented == false {
                
                header1optionsHide()
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.header2View.center = self.header2ViewExpandPosition
                    self.header3View.center = self.header3ViewExpandPosition
                    }, completion: nil)
                header3optionsShow()
                
            } else if header2HasBeenPresented == true && header3HasBeenPresented == true {
                
                header1optionsHide()
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.header2View.center = self.header2ViewExpandPosition
                    self.header3View.center = self.header3ViewExpandPosition
                    self.buttonCoverView.alpha = 0
                    }, completion: nil)
            }
        }
    }
    
    @IBAction func onHeader2Tap(sender: AnyObject) {
        
        println("i'm tapping header 2")
        
        workoutTypeButton.setTitle(("Workout Type"), forState: .Normal)
        
        if header2optionsShown == false {
            
            if header3HasBeenPresented == false {
                header2optionsShow()
                header1optionsHide()
                
            } else if header3HasBeenPresented == true {
                header1optionsHide()
                header2optionsShow()
                header3optionsHide()
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.header3View.center = CGPoint(x: self.header3View.center.x, y: self.header2option3.center.y + 72)
                    self.header2View.center = self.header2ViewExpandPosition
                    self.buttonCoverView.alpha = 0.95
                    }, completion: nil)
            }
        } else if header2optionsShown == true {
            
            self.workoutTypeButton.setTitle("\(sender.titleLabel!!.text!)", forState: .Normal)
            
            if header3HasBeenPresented == false {
                header2optionsHide()
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.header3View.center = self.header3ViewExpandPosition
                    }, completion: nil)
                header3optionsShow()
            } else if header3HasBeenPresented == true {
                header2optionsHide()
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.header3View.center = self.header3ViewExpandPosition
                    self.header2View.center = self.header2ViewExpandPosition
                    self.buttonCoverView.alpha = 0
                    }, completion: nil)
            }
        }
    }
    
    @IBAction func onHeader3Tap(sender: AnyObject) {
        
        println("i'm tapping header 3")
        locationButton.setTitle(("Location"), forState: .Normal)
        
        if header3optionsShown == false {
            
            header3optionsShow()
            header1optionsHide()
            header2optionsHide()
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.header3View.center = self.header3ViewExpandPosition
                self.buttonCoverView.alpha = 0.95
                self.header2View.center = self.header2ViewExpandPosition
                }, completion: nil)
            
        } else if header3optionsShown == true {
            
            header3optionsHide()
            
            self.locationButton.setTitle("\(sender.titleLabel!!.text!)", forState: .Normal)
            
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.buttonCoverView.alpha = 0
                }, completion: nil)
        }
    }
    
    @IBAction func onOption1ButtonTap(sender: UIButton) {
        
        header1option1Button.selected = false
        header1option2Button.selected = false
        header1option3Button.selected = false
        header1option4Button.selected = false
        sender.selected = true
        
        // pull pull from here in PrepareForSegue
        durationSelection = sender.titleLabel?.text
        
        durationButton.setTitle("\(sender.titleLabel!.text!)", forState: .Normal)
        
        if header2HasBeenPresented == false {
            
            header1optionsHide()
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.header2View.center = self.header2ViewExpandPosition
                }, completion: nil)
            header2optionsShow()
            
        } else if header2HasBeenPresented == true && header3HasBeenPresented == false {
            header1optionsHide()
            
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.header2View.center = self.header2ViewExpandPosition
                }, completion: nil)
            
        } else if header2HasBeenPresented == true && header3HasBeenPresented == true {
            header1optionsHide()
            
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.header2View.center = self.header2ViewExpandPosition
                self.header3View.center = self.header3ViewExpandPosition
                self.buttonCoverView.alpha = 0
                }, completion: nil)
        }
    }
    
    @IBAction func onOption2ButtonTap(sender: UIButton) {
        
        header2option1Button.selected = false
        header2option2Button.selected = false
        header2option3Button.selected = false
        sender.selected = true
        
        // pull pull from here in PrepareForSegue
        typeSelection = sender.titleLabel?.text
        
        workoutTypeButton.setTitle("\(sender.titleLabel!.text!)", forState: .Normal)
        
        if header3HasBeenPresented == false {
            
            header2optionsHide()
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.header3View.center = self.header3ViewExpandPosition
                }, completion: nil)
            header3optionsShow()
            
        } else if header3HasBeenPresented == true {
            header2optionsHide()
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.header3View.center = self.header3ViewExpandPosition
                self.buttonCoverView.alpha = 0
                }, completion: nil)
        }
    }
    
    @IBAction func onOption3ButtonTap(sender: UIButton) {
        
        if header3option1Button.selected == false && header3option2Button.selected == false {
            sender.selected = true
            locationButton.setTitle("\(sender.titleLabel!.text!)" + " Workout", forState: .Normal)
            header3optionsHide()
            delay(0.2, { () -> () in
                UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.buttonCoverView.alpha = 0
                    self.generateWorkoutButton.center = self.generateWorkoutButtonShown
                    }, completion: nil)
            })
            
        } else {
            header3option1Button.selected = false
            header3option2Button.selected = false
            sender.selected = true
            
            // pull pull from here in PrepareForSegue
            locationSelection = sender.titleLabel?.text
            
            locationButton.setTitle("\(sender.titleLabel!.text!)" + " Workout", forState: .Normal)
            
            header3optionsHide()
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.buttonCoverView.alpha = 0
                }, completion: nil)
        }
    }
    
    
    func header1optionsShow() {
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.header1View.layer.backgroundColor = self.listItemSelectedColor.CGColor
            self.durationButton.setTitleColor(self.descriptionSelectedColor, forState: UIControlState.Normal)
            
            self.header1option1.center = self.header1option1Shown
            self.header1option2.center = self.header1option2Shown
            self.header1option3.center = self.header1option3Shown
            self.header1option4.center = self.header1option4Shown
            
            
            
            }, completion: nil)
        self.header1optionsShown = true
        
    }
    
    func header1optionsHide() {
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.header1View.layer.backgroundColor = self.listItemColor.CGColor
            self.durationButton.setTitleColor(self.descriptionColor, forState: UIControlState.Normal)

            
            self.header1option1.center = self.header1option1Hidden
            self.header1option2.center = self.header1option2Hidden
            self.header1option3.center = self.header1option3Hidden
            self.header1option4.center = self.header1option4Hidden
            
            
            
            }, completion: nil)
        self.header1optionsShown = false
        
    }
    
    func header2optionsShow() {
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.header2View.layer.backgroundColor = self.listItemSelectedColor.CGColor
            self.workoutTypeButton.setTitleColor(self.descriptionSelectedColor, forState: UIControlState.Normal)
            
            self.header2option1.alpha = 1
            self.header2option2.alpha = 1
            self.header2option3.alpha = 1
            
            self.header2option1.center = self.header2option1Shown
            self.header2option2.center = self.header2option2Shown
            self.header2option3.center = self.header2option3Shown
            
            }, completion: nil)
        
        self.header2optionsShown = true
        self.header2HasBeenPresented = true
    }
    
    func header2optionsHide() {
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.header2View.layer.backgroundColor = self.listItemColor.CGColor
            self.workoutTypeButton.setTitleColor(self.descriptionColor, forState: UIControlState.Normal)
            
            self.header2option1.center = self.header2option1Hidden
            self.header2option2.center = self.header2option2Hidden
            self.header2option3.center = self.header2option3Hidden
            
            self.header2option1.alpha = 0
            self.header2option2.alpha = 0
            self.header2option3.alpha = 0
            
            }, completion: nil)
        self.header2optionsShown = false
        
    }
    
    func header3optionsShow() {
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.header3View.layer.backgroundColor = self.listItemSelectedColor.CGColor
            self.locationButton.setTitleColor(self.descriptionSelectedColor, forState: UIControlState.Normal)
            
            self.header3option1.alpha = 1
            self.header3option2.alpha = 1
            
            self.header3option1.center = self.header3option1Shown
            self.header3option2.center = self.header3option2Shown
            
            }, completion: nil)
        
        self.header3optionsShown = true
        self.header3HasBeenPresented = true
    }
    
    func header3optionsHide() {
        
        self.header3View.layer.backgroundColor = self.listItemColor.CGColor
        self.locationButton.setTitleColor(self.descriptionColor, forState: UIControlState.Normal)
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.header3option1.center = self.header3option1Hidden
            self.header3option2.center = self.header3option2Hidden
            
            self.header3option1.alpha = 0
            self.header3option2.alpha = 0
            
            
            }, completion: nil)
        self.header3optionsShown = false
        
    }
    
    @IBAction func onTapToExposeButton(sender: AnyObject) {
        
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.header1optionsHide()
            self.header2optionsHide()
            self.header3optionsHide()
            self.header2View.center = self.header2ViewExpandPosition
            self.header3View.center = self.header3ViewExpandPosition
            self.buttonCoverView.alpha = 0
            
            }, completion: nil)
    }
    
    @IBAction func onTapToShowProfile(sender: AnyObject) {
        onNavigationButtonPressed()

        if profileButton.selected == false {
            profileButton.selected = true
        } else {
            profileButton.selected = false
        }

//        NSNotificationCenter.defaultCenter().postNotificationName("displayTrayUI", object: nil)
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
