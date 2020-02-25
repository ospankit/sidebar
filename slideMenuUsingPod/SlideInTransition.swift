//
//  SlideInTransition.swift
//  slideMenuUsingPod
//
//  Created by Ankit on 24/02/20.
//  Copyright © 2020 Ankit. All rights reserved.
//

import UIKit

class SlideInTransition:NSObject,UIViewControllerAnimatedTransitioning {
    
    var isPresenting = false

    let dimmingView = UIView()
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from) else {return}
        
        let containerView = transitionContext.containerView
        
        let finalHeight = toViewController.view.bounds.height
        let finalWidth = toViewController.view.bounds.width * 0.8
        
        if isPresenting {
            dimmingView.backgroundColor = .black
            dimmingView.alpha = 0.0
            containerView.addSubview(dimmingView)
            dimmingView.frame = containerView.bounds
            
            containerView.addSubview(toViewController.view)
            
            toViewController.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
        }
        
        //animate on screen
        let transform = {
            self.dimmingView.alpha = 0.5
            toViewController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
        }
        
        //animate back of screen
        let identity = {
            self.dimmingView.alpha = 0.0
            fromViewController.view.transform = .identity
        }
        
        //Animation of transition
        let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: duration, animations: {
            self.isPresenting ? transform() : identity()
        }) { (_) in
            transitionContext.completeTransition(!isCancelled)
        }
        
    }
    
    
}
