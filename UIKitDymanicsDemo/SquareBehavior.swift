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
    lazy var elasticityBehavior:UIDynamicItemBehavior = {
        let lazyBehavior = UIDynamicItemBehavior()
        lazyBehavior.elasticity = self.animationSettings.elasticity
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
        addChildBehavior(elasticityBehavior)
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
        elasticityBehavior.addItem(squareView)
    }
    
    func removeSquare(squareView: UIView){
        gravity.removeItem(squareView)
        collider.removeItem(squareView)
        elasticityBehavior.removeItem(squareView)
    }
    
    func addViewToCollider(view: UIView){
        collider.addItem(view)
    }
    
    func setCollisionDelegate(delegate: UICollisionBehaviorDelegate){
        self.collider.collisionDelegate = delegate
    }
}
