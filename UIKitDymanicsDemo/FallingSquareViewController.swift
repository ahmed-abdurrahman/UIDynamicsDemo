//
//  FallingSquareViewController.swift
//  UIKitDymanicsDemo
//
//  Created by Ahmed Abdurrahman on 10/21/15.
//  Copyright © 2015 A. Abdurrahman. All rights reserved.
//

import UIKit

class FallingSquareViewController: UIViewController {

    @IBOutlet var animationView: UIView!
    var squareView:UIView!
    
    lazy var animator: UIDynamicAnimator = {
        return UIDynamicAnimator(referenceView: self.animationView)
        }()
    
    lazy var gravity:UIGravityBehavior = {
        let lazyGravity = UIGravityBehavior()
        return lazyGravity
        }()
    
    lazy var collider:UICollisionBehavior = {
        let lazyCollider = UICollisionBehavior()
        // This line, makes the boundries of our reference view a boundary
        // for the added items to collide with.
        lazyCollider.translatesReferenceBoundsIntoBoundary = true
        return lazyCollider
        }()

    lazy var dynamicItemBehavior:UIDynamicItemBehavior = {
        let lazyBehavior = UIDynamicItemBehavior()
        lazyBehavior.elasticity = 0.8

        // Other configurations
//        lazyBehavior.allowsRotation
//        lazyBehavior.density
//        lazyBehavior.friction
//        lazyBehavior.resistance
        
        return lazyBehavior
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawSquare()
        animateSquare()
    }
    
    func drawSquare(){
        let squareSize = CGSize(width: 30.0, height: 30.0)
        let centerPoint = CGPoint(x: self.animationView.bounds.midX - (squareSize.width/2), y: self.animationView.bounds.midY - (squareSize.height/2))
        let frame = CGRect(origin: centerPoint, size: squareSize)
        squareView = UIView(frame: frame)
        squareView.backgroundColor = UIColor.orangeColor()

        animationView.addSubview(squareView)
    }
    
    func animateSquare(){
        // 1. Add behaviors to the animator
        animator.addBehavior(gravity)
        animator.addBehavior(collider)
        animator.addBehavior(dynamicItemBehavior)

        // 2. Add items to the behavior
        gravity.addItem(squareView)
        collider.addItem(squareView)
        dynamicItemBehavior.addItem(squareView)
    }
}
