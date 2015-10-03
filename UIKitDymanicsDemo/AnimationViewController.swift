//
//  AnimationViewController.swift
//  UIKitDymanicsDemo
//
//  Created by Ahmed Abdurrahman on 10/3/15.
//  Copyright © 2015 A. Abdurrahman. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {

    @IBOutlet weak var animationView: UIView!
    let sizes:[CGSize] = [
//        CGSize(width: 20.0, height: 20.0),
        CGSize(width: 30.0, height: 30.0)]
    let colors = [UIColor.redColor(),
        UIColor.orangeColor(),
        UIColor.yellowColor(),
        UIColor.greenColor(),
        UIColor.blueColor()]
    var hammerView:UIView!
    var snap: UISnapBehavior?
    
    let squareBehavior = SquareBehavior()
    
    lazy var animator: UIDynamicAnimator = {
        return UIDynamicAnimator(referenceView: self.animationView)
        }()
    lazy var rightCanon: CGPoint = {
        let point = CGPoint(x: self.animationView.bounds.width-40.0, y: self.animationView.bounds.height * 0.5)
        return point
        }()
    lazy var leftCanon: CGPoint = {
        let point = CGPoint(x: 0, y: self.animationView.bounds.height * 0.5)
        return point
        }()
    
    var rightCanonTurn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(squareBehavior)
        setupHammer()
    }
    
    @IBAction func viewTap(sender: UITapGestureRecognizer) {
        let color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
        let size = sizes[Int(arc4random_uniform(UInt32(sizes.count)))]
        let frame:CGRect!
        let pushBehavior : UIPushBehavior!
        
        if rightCanonTurn {
            frame = CGRect(origin: rightCanon, size: size)
            pushBehavior = createPushBehavior(CGFloat(M_PI * 1.35))
            rightCanonTurn = false
        } else {
            frame = CGRect(origin: leftCanon, size: size)
            pushBehavior = createPushBehavior(CGFloat(M_PI * 1.65))
            rightCanonTurn = true
        }
        
        let squareView = UIView(frame: frame)
        
        
        squareView.backgroundColor = color
        
        animationView.addSubview(squareView)
        squareBehavior.addSquare(squareView)
        pushBehavior.addItem(squareView)
    }
    
    func setupHammer(){
        let centerPoint = CGPoint(x: animationView.bounds.midX, y: animationView.bounds.midY)
        let frame = CGRect(origin: centerPoint, size: CGSize(width: 20.0, height: 20.0))
        hammerView = UIView(frame: frame)
        hammerView.backgroundColor = UIColor.blackColor()
        hammerView.layer.cornerRadius = 10.0
        
        animationView.addSubview(hammerView)
        squareBehavior.addViewToCollider(hammerView)
        
        let snap = UISnapBehavior(item: hammerView, snapToPoint: centerPoint)
        snap.damping = 1.0
        animator.addBehavior(snap)
    }
    
    func createPushBehavior(angle: CGFloat)->UIPushBehavior {
        let pushUp = UIPushBehavior(items: [], mode: UIPushBehaviorMode.Instantaneous)
        pushUp.magnitude = 0.8
        pushUp.angle = angle
        animator.addBehavior(pushUp)
        return pushUp
    }

}
