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
    @IBOutlet weak var elasticitySlider: UISlider!
    @IBOutlet weak var pushMagnitudeSlider: UISlider!
    @IBOutlet weak var snapDampingSlider: UISlider!
    @IBOutlet weak var densitySlider: UISlider!
    @IBOutlet weak var frictionSlider: UISlider!
    @IBOutlet weak var resistanceSlider: UISlider!
    @IBOutlet weak var allowsRotationSwitch: UISwitch!
    
    var animationSettings = AnimationSettings()
    let animationSegue = "gotoAnimation"

    @IBAction func gotoAnimationView() {
        self.performSegueWithIdentifier(animationSegue, sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == animationSegue {
            let animationsViewController = segue.destinationViewController as? AnimationViewController
            animationSettings.elasticity = CGFloat(elasticitySlider.value)
            animationSettings.pushMagnitude = CGFloat(pushMagnitudeSlider.value)
            animationSettings.gravity = CGFloat(gravitySlider.value)
            animationSettings.snapDamping = CGFloat(snapDampingSlider.value)
            animationSettings.squareDensity = CGFloat(densitySlider.value)
            animationSettings.friction = CGFloat(frictionSlider.value)
            animationSettings.resistance = CGFloat(resistanceSlider.value)
            animationSettings.allowRotation = allowsRotationSwitch.on
            animationsViewController?.animationSettings = animationSettings
        }
    }
}

struct AnimationSettings {
    var gravity: CGFloat = 0.5
    var elasticity: CGFloat = 0.5
    var pushMagnitude: CGFloat = 0.5
    var snapDamping: CGFloat = 0.5
    var squareDensity: CGFloat = 0.5
    var friction: CGFloat = 0.5
    var resistance: CGFloat = 0.5
    var allowRotation: Bool = true
}
