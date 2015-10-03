//
//  SquareBehavior.swift
//  UIKitDymanicsDemo
//
//  Created by Ahmed Abdurrahman on 10/3/15.
//  Copyright © 2015 A. Abdurrahman. All rights reserved.
//

import UIKit

class SquareBehavior: UIDynamicBehavior {
    
    let gravity = UIGravityBehavior()
    lazy var collider:UICollisionBehavior = {
        let lazyCollider = UICollisionBehavior()
        lazyCollider.translatesReferenceBoundsIntoBoundary = true
        return lazyCollider
        }()
    lazy var elacticityBehavior:UIDynamicItemBehavior = {
        let lazyBehavior = UIDynamicItemBehavior()
        lazyBehavior.elasticity = 0.7
        lazyBehavior.allowsRotation = true
        return lazyBehavior
        }()
    
    override init(){
        super.init()
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
    
    func addFlipper(flipperView:UIView, horizontalOffset:CGFloat, anchorPoint: CGPoint){
        gravity.addItem(flipperView)
        collider.addItem(flipperView)
        
        let attachmentBehavior = UIAttachmentBehavior(item: flipperView, offsetFromCenter: UIOffset(horizontal: horizontalOffset, vertical: flipperView.bounds.height/3.0), attachedToAnchor: anchorPoint)
        attachmentBehavior.length = 0.0
        attachmentBehavior.damping = 0.0
        attachmentBehavior.frequency = 0.0
        addChildBehavior(attachmentBehavior)
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
