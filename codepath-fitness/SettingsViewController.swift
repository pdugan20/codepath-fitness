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
    
    var header1optionsShown: Bool!
    
    @IBOutlet weak var header2View: UIView!
    @IBOutlet weak var header2option1: UIView!
    @IBOutlet weak var header2option2: UIView!
    @IBOutlet weak var header2option3: UIView!

    var header2ViewOriginalCenter: CGPoint!
    var header2ViewExpandPosition: CGPoint!
    var header2option1Hidden: CGPoint!
    var header2option1Shown: CGPoint!
    var header2option2Hidden: CGPoint!
    var header2option2Shown: CGPoint!
    var header2option3Hidden: CGPoint!
    var header2option3Shown: CGPoint!
    
    var header2optionsShown: Bool!
    
    @IBOutlet weak var header3View: UIView!

    var header3ViewOriginalCenter: CGPoint!
    var header3ViewPosition2: CGPoint!
    
    var header3optionsShown: Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        header1ViewOriginalCenter = header1View.center
        
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
        
        header1optionsShown = false
        header2optionsShown = false

        header2option1.alpha = 0
        header2option2.alpha = 0
        header2option3.alpha = 0

        header2ViewOriginalCenter = header2View.center
        header2ViewExpandPosition = CGPoint(x: header2View.center.x, y:header1View.center.y + 72)
        
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
        header3ViewPosition2 = CGPoint(x: header3View.center.x, y: header2option3Shown.y + 74)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onHeader1Tap(sender: AnyObject) {
        
        if header1optionsShown == false {
    
            header1optionsShow()
            
        } else {

            header1optionsHide()
        }
        

    }
    
    @IBAction func onOption1ButtonTap(sender: AnyObject) {
        
            header1optionsHide()
            header2optionsShow()
    }
    
    
    func header1optionsShow () {
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.header1option1.center = self.header1option1Shown
            self.header1option2.center = self.header1option2Shown
            self.header1option3.center = self.header1option3Shown
            self.header1option4.center = self.header1option4Shown

            self.header2View.center = self.header2ViewOriginalCenter

            
            }, completion: nil)
        self.header1optionsShown = true
    }
    
    func header1optionsHide () {
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.header1option1.center = self.header1option1Hidden
            self.header1option2.center = self.header1option2Hidden
            self.header1option3.center = self.header1option3Hidden
            self.header1option4.center = self.header1option4Hidden
            
            self.header2View.center = self.header2ViewExpandPosition
            
            }, completion: nil)
        self.header1optionsShown = false
        
    }
    
    func header2optionsShow () {
        UIView.animateWithDuration(0.3, delay: 0.3, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.header2option1.alpha = 1
            self.header2option2.alpha = 1
            self.header2option3.alpha = 1
            
            self.header2option1.center = self.header2option1Shown
            self.header2option2.center = self.header2option2Shown
            self.header2option3.center = self.header2option3Shown

            self.header3View.center = self.header3ViewPosition2
            
            }, completion: nil)
        self.header1optionsShown = true
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
