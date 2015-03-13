//
//  NavigationControllerDelegate.swift
//  CircleTransition
//
//  Created by Tim Geng on 3/13/15.
//  Copyright (c) 2015 GF. All rights reserved.
//

import UIKit

class NavigationControllerDelegate: NSObject,UINavigationControllerDelegate {

    @IBOutlet weak var navigationController : UINavigationController?;
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return CircleTransitionAnimator();
    }
    
    var interactionController: UIPercentDrivenInteractiveTransition?;
    
    func navigationController(navigationController: UINavigationController,
        interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
            return self.interactionController
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        var panGesture = UIPanGestureRecognizer(target: self, action: Selector("panned:"));
        self.navigationController!.view.addGestureRecognizer(panGesture);
    }
    
    @IBAction func panned(gestureRecognizer : UIPanGestureRecognizer){
        
        switch gestureRecognizer.state{
        case .Began:
            self.interactionController = UIPercentDrivenInteractiveTransition();
            if self.navigationController?.viewControllers.count > 1{
                self.navigationController?.popViewControllerAnimated(true);
            }else{
                self.navigationController?.topViewController.performSegueWithIdentifier("PushSegue", sender: nil);
            }
        case .Changed:
            var translation = gestureRecognizer.translationInView(self.navigationController!.view);
            var completionProgress = translation.x / CGRectGetWidth(self.navigationController!.view.bounds);
            self.interactionController?.updateInteractiveTransition(completionProgress);
        case .Ended:
            if (gestureRecognizer.velocityInView(self.navigationController!.view).x > 0 ){
                self.interactionController?.finishInteractiveTransition();
            }else{
                self.interactionController?.cancelInteractiveTransition();
            }
            self.interactionController = nil;
        default:
            self.interactionController?.cancelInteractiveTransition();
            self.interactionController = nil;
        }
        
    }
}
