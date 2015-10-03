//
//  SettingsTableViewController.swift
//  UIKitDymanicsDemo
//
//  Created by Ahmed Abdurrahman on 10/3/15.
//  Copyright © 2015 A. Abdurrahman. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var gravitySlider: UISlider!
    @IBOutlet weak var elacticitySlider: UISlider!
    @IBOutlet weak var pushMagnitudeSlider: UISlider!
    @IBOutlet weak var snapDampingSlider: UISlider!
    
    var animationSettings = AnimationSettings()
    
    
    /*
        Angular resistance
        Allows Rotation
    */
    @IBAction func gotoAnimationView() {
        self.performSegueWithIdentifier("gotoAnimation", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gotoAnimation" {
            let animationsViewController = segue.destinationViewController as? AnimationViewController
            animationSettings.elacticity = CGFloat(elacticitySlider.value)
            animationSettings.pushMagnitude = CGFloat(pushMagnitudeSlider.value)
            animationSettings.gravity = CGFloat(gravitySlider.value)
            animationsViewController?.animationSettings = animationSettings
        }
    }
}

struct AnimationSettings {
    var gravity: CGFloat = 0.5
    var elacticity: CGFloat = 0.5
    var pushMagnitude: CGFloat = 0.5
    var snapDamping: CGFloat = 0.5
    
    /*
        density 0 to 1
        friction 0 to 1
        resistance 0 to 1
        allowsRotation : Bool


    */
}
