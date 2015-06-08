//
//  BaseTransition.swift
//  transitionDemo
//
//  Created by Timothy Lee on 2/22/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BaseTransition: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    var duration: NSTimeInterval = 0.4
    var isPresenting: Bool = true
    var isInteractive: Bool = false
    var transitionContext: UIViewControllerContextTransitioning!
    var interactiveTransition: UIPercentDrivenInteractiveTransition!
    
    var percentComplete: CGFloat = 0 {
        didSet {
            interactiveTransition.updateInteractiveTransition(percentComplete)
        }
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return duration
    }
    
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if isInteractive {
            interactiveTransition = UIPercentDrivenInteractiveTransition()
            interactiveTransition.completionSpeed = 0.99
        } else {
            interactiveTransition = nil
        }
        return interactiveTransition
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        self.transitionContext = transitionContext
        
        if (isPresenting) {
            containerView.addSubview(toViewController.view)
            presentTransition(containerView, fromViewController: fromViewController, toViewController: toViewController)
        } else {
            dismissTransition(containerView, fromViewController: fromViewController, toViewController: toViewController)
        }
    }
    
    func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
    }
    
    func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
    }
    
    func finish() {
        if isInteractive {
            interactiveTransition.finishInteractiveTransition()
        }
        
        if isPresenting == false {
            var fromViewController = transitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)!
            fromViewController?.view.removeFromSuperview()
        }
        
        transitionContext?.completeTransition(true)
    }
    
    func cancel() {
        if isInteractive {
            interactiveTransition.cancelInteractiveTransition()
        }
    }
    
}
