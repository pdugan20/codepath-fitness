//
//  ProfileViewController.swift
//  codepath-fitness
//
//  Created by Patrick Weiss on 6/20/15.
//  Copyright (c) 2015 PPK Inc. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var setupView: UIView!

    var profileViewController: UIViewController!
    var setupViewController: SettingsViewController!

    
    var setupViewOriginalCenter: CGPoint!
    var setupViewLockedToBottom: CGPoint!
    
    var profileExposed: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewOriginalCenter = setupView.center
        setupViewLockedToBottom = CGPoint(x: setupView.center.x, y: setupViewOriginalCenter.y + 492)
        
        profileExposed = false

        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        profileViewController = storyboard.instantiateViewControllerWithIdentifier("ProfileContentViewController") as! UIViewController
        setupViewController = storyboard.instantiateViewControllerWithIdentifier("SettingsViewController") as! SettingsViewController

//    NSNotificationCenter.defaultCenter().addObserver(self, selector: displayTrayUI, name: "displayTrayUI", object: nil)
        
        setupViewController.onNavigationButtonPressed = {
            println("wants display ui")
            
            if self.profileExposed == false {
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
                    self.setupView.center = self.setupViewLockedToBottom
                    }, completion: nil)
                self.profileExposed = true
                
                
            } else {
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
                    self.setupView.center = self.setupViewOriginalCenter
                    }, completion: nil)
                self.profileExposed = false
                
            }
            
            


        }
        
        hideMenu()
        showMenu()
        
        
    }
    
//    func displayTrayUI -> Void {
//        
//    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showMenu() {
        addChildViewController(profileViewController)
        profileView.addSubview(profileViewController.view)
        profileViewController.didMoveToParentViewController(self)
        
    }
    
    func hideMenu() {
        addChildViewController(setupViewController)
        setupView.addSubview(setupViewController.view)
        setupViewController.didMoveToParentViewController(self)
    }
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
