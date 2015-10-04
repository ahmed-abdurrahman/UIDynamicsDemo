//
//  AnimationViewController.swift
//  UIKitDymanicsDemo
//
//  Created by Ahmed Abdurrahman on 10/3/15.
//  Copyright © 2015 A. Abdurrahman. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController, UICollisionBehaviorDelegate {

    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var collisionMessageLabel: UILabel! {
        didSet {
            collisionMessageLabel.layer.masksToBounds = true
            collisionMessageLabel.layer.cornerRadius = 5
        }
    }
    
    let squareSize:CGSize = CGSize(width: 30.0, height: 30.0)
    let colors = [UIColor.redColor(),
        UIColor.orangeColor(),
        UIColor.yellowColor(),
        UIColor.greenColor(),
        UIColor.blueColor()]
    let collisionMessages = ["Ouch!", "Oh, it hurts.", "Hey, keep your squares away!"]
    let snappingCirlceTag = 1000
    
    var snappingCircleView:UIView!
    var snap: UISnapBehavior?
    var animationSettings: AnimationSettings!
    var rightCanonTurn = true
    
    lazy var animator: UIDynamicAnimator = {
        return UIDynamicAnimator(referenceView: self.animationView)
        }()
    lazy var squareBehavior: SquareBehavior = {
        let lazySquareBehavior = SquareBehavior(settings: self.animationSettings)
        self.animator.addBehavior(lazySquareBehavior)
        lazySquareBehavior.collider.collisionDelegate = self
        return lazySquareBehavior
        }()
    lazy var rightCanon: CGPoint = {
        let point = CGPoint(x: self.animationView.bounds.width-40.0, y: self.animationView.bounds.height * 0.5)
        return point
        }()
    lazy var leftCanon: CGPoint = {
        let point = CGPoint(x: 0, y: self.animationView.bounds.height * 0.5)
        return point
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSnappingCircle()
    }
    
    @IBAction func viewTap(sender: UITapGestureRecognizer) {
        pushNewSquare()
    }
    
    func pushNewSquare(){
        let color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
        let frame:CGRect!
        let pushBehavior : UIPushBehavior!
        
        if rightCanonTurn {
            frame = CGRect(origin: rightCanon, size: squareSize)
            pushBehavior = createPushBehavior(CGFloat(M_PI * 1.35))
            rightCanonTurn = false
        } else {
            frame = CGRect(origin: leftCanon, size: squareSize)
            pushBehavior = createPushBehavior(CGFloat(M_PI * 1.65))
            rightCanonTurn = true
        }
        
        let squareView = UIView(frame: frame)
        
        
        squareView.backgroundColor = color
        
        animationView.addSubview(squareView)
        squareBehavior.addSquare(squareView)
        pushBehavior.addItem(squareView)
    }
    
    func setupSnappingCircle(){
        let centerPoint = CGPoint(x: animationView.bounds.midX, y: animationView.bounds.midY)
        let frame = CGRect(origin: centerPoint, size: CGSize(width: 20.0, height: 20.0))
        snappingCircleView = UIView(frame: frame)
        snappingCircleView.backgroundColor = UIColor.blackColor()
        snappingCircleView.layer.cornerRadius = 10.0
        
        snappingCircleView.tag = snappingCirlceTag
        animationView.addSubview(snappingCircleView)
        squareBehavior.addViewToCollider(snappingCircleView)
        
        let snap = UISnapBehavior(item: snappingCircleView, snapToPoint: centerPoint)
        snap.damping = animationSettings.snapDamping
        animator.addBehavior(snap)
    }
    
    func createPushBehavior(angle: CGFloat)->UIPushBehavior {
        let pushBehavior = UIPushBehavior(items: [], mode: UIPushBehaviorMode.Instantaneous)
        pushBehavior.magnitude = animationSettings.pushMagnitude
        pushBehavior.angle = angle
        pushBehavior.action = { [unowned pushBehavior] in
            pushBehavior.dynamicAnimator!.removeBehavior(pushBehavior)
        }
        animator.addBehavior(pushBehavior)
        return pushBehavior
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint){
        
        if (item1 as? UIView)?.tag == snappingCirlceTag || (item2 as? UIView)?.tag == snappingCirlceTag {
            let message = collisionMessages[Int(arc4random_uniform(UInt32(collisionMessages.count)))]
            displayCollisionMessage(message)
        }
    }
    
    func displayCollisionMessage(message: String){
        if collisionMessageLabel.hidden {
            collisionMessageLabel.alpha = 0
            collisionMessageLabel.hidden = false
            UIView.animateWithDuration(0.5){
                self.collisionMessageLabel.text = message
                self.collisionMessageLabel.alpha = 0.9
                UIView.animateWithDuration(0.3, delay: 2.0, options: .CurveEaseOut, animations: { () -> Void in
                    self.collisionMessageLabel.alpha = 0.0
                    
                    }, completion: { (_) -> Void in
                        self.collisionMessageLabel.hidden = true
                })
            }
        }
    }

}
