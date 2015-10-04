//
//  SquareBehavior.swift
//  UIKitDymanicsDemo
//
//  Created by Ahmed Abdurrahman on 10/3/15.
//  Copyright © 2015 A. Abdurrahman. All rights reserved.
//

import UIKit

class SquareBehavior: UIDynamicBehavior {
    
    var animationSettings: AnimationSettings!
    
    lazy var gravity:UIGravityBehavior = {
        let lazyGravity = UIGravityBehavior()
        lazyGravity.magnitude = self.animationSettings.gravity
        return lazyGravity
    }()
    lazy var collider:UICollisionBehavior = {
        let lazyCollider = UICollisionBehavior()
        lazyCollider.translatesReferenceBoundsIntoBoundary = true
        return lazyCollider
        }()
    lazy var elacticityBehavior:UIDynamicItemBehavior = {
        let lazyBehavior = UIDynamicItemBehavior()
        lazyBehavior.elasticity = self.animationSettings.elacticity
        lazyBehavior.allowsRotation = self.animationSettings.allowRotation
        lazyBehavior.density = self.animationSettings.squareDensity
        lazyBehavior.friction = self.animationSettings.friction
        lazyBehavior.resistance = self.animationSettings.resistance
        
        return lazyBehavior
        }()
    
    init(settings: AnimationSettings){
        super.init()
        self.animationSettings = settings
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(elacticityBehavior)
    }
    
    func addBarrier(path: UIBezierPath, named name: String){
        collider.removeBoundaryWithIdentifier(name)
        collider.addBoundaryWithIdentifier(name, forPath: path)
    }
    
    func addBarrier(fromPoint: CGPoint, toPoint: CGPoint, named name: String){
        collider.removeBoundaryWithIdentifier(name)
        collider.addBoundaryWithIdentifier(name, fromPoint: fromPoint, toPoint: toPoint)
    }
    
    func addSquare(squareView:UIView){
        gravity.addItem(squareView)
        collider.addItem(squareView)
        elacticityBehavior.addItem(squareView)
    }
    
    func addViewToCollider(view: UIView){
        collider.addItem(view)
    }
    
    func removeSquare(squareView: UIView){
        gravity.removeItem(squareView)
        collider.removeItem(squareView)
        elacticityBehavior.removeItem(squareView)
    }
    
    func setCollisionDelegate(delegate: UICollisionBehaviorDelegate){
        self.collider.collisionDelegate = delegate
    }
}
