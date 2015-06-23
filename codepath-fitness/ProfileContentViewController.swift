//
//  profileContentViewController.swift
//  codepath-fitness
//
//  Created by Patrick Weiss on 6/20/15.
//  Copyright (c) 2015 PPK Inc. All rights reserved.
//

import UIKit

class ProfileContentViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = profileImageView.image!.size

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
