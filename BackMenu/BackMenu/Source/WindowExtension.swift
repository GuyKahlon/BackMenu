//
//  WindowExtension.swift
//  BackMenu
//
//  Created by Guy Kahlon on 1/25/15.
//  Copyright (c) 2015 GuyKahlon. All rights reserved.
//

import UIKit

private var beganOrigin = CGPoint()

private let kHeaderHeight: CGFloat = 64
private let kTransform: CGFloat = 0.9
private let kAlphe: CGFloat = 0.4
private let kAnimationDuration: NSTimeInterval = 0.3
private let kstatusBarStyle = UIStatusBarStyle.LightContent

var tapGesture : UITapGestureRecognizer?
var panGesture : UIPanGestureRecognizer?
let backWindow:UIWindow? = UIApplication.sharedApplication().delegate?.window!

extension UIWindow{
    
    func stopSwipeToOpenMenu(){
        
        if let pan = panGesture{
            removeGestureRecognizer(pan)
        }
        if let tap = tapGesture{
            removeGestureRecognizer(tap)
        }
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func startSwipeToOpenMenu(){
        
        panGesture = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        addGestureRecognizer(panGesture!);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }

    func handlePanGesture(panGesture : UIPanGestureRecognizer){
        
        let translation:CGPoint = panGesture.translationInView(self);
        let velocity:CGPoint = panGesture.velocityInView(self)
        
        switch (panGesture.state){
            
        case .Began:
            beganOrigin = frame.origin;
            break;
        case .Changed:
            
            let val = (frame.origin.y * ((1 - kTransform) / UIScreen.mainScreen().bounds.height)) + kTransform;
            let t1 = CATransform3DScale(CATransform3DIdentity, val , val , 1);
            
            let valAlphe = (frame.origin.y * ((1 - kAlphe) / UIScreen.mainScreen().bounds.height)) + kAlphe;
            
            if beganOrigin.y + translation.y >= -kHeaderHeight{
                
                self.transform = CGAffineTransformMakeTranslation(0, translation.y);
                backWindow?.rootViewController?.view.layer.transform = t1;
                backWindow?.rootViewController?.view.alpha = valAlphe;
            }
        case .Ended, .Cancelled:
            
            var finalOrigin:CGPoint = CGPointZero;
            var finalTransform: CATransform3D = CATransform3DIdentity
            var alpha: CGFloat = 1.0;
            var statusBarStyle = kstatusBarStyle
            if velocity.y >= 0 {
                finalOrigin.y = CGRectGetHeight(UIScreen.mainScreen().bounds) - kHeaderHeight;
                 addTapGestureToClose()
            }
            else{
                finalTransform = CATransform3DScale(finalTransform, kTransform , kTransform , 1);
                alpha = kAlphe
                statusBarStyle = UIStatusBarStyle.Default
                removeTapGestureToClose()
            }
            
            var finalFrame = frame;
            finalFrame.origin = finalOrigin;
            
            UIView.animateWithDuration(kAnimationDuration, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in
                
                backWindow?.rootViewController?.view.layer.transform = finalTransform;
                backWindow?.rootViewController?.view.alpha = alpha;
                
                self.transform = CGAffineTransformIdentity;
                self.frame = finalFrame;
                UIApplication.sharedApplication().setStatusBarStyle(statusBarStyle, animated:true)
                }, completion: { (finished: Bool) -> Void in
            })
        default:
            print("Unknown panGesture state")
        }
    }
    
    func handleTapGesture(panGesture : UIPanGestureRecognizer){
        close()
    }
    
    func keyboardWillShow(notification: NSNotification){
        hidden = true
    }
    
    func keyboardWillHide(notification: NSNotification){
        hidden = false
    }

    // MARK: Private methids
    private func close(){
        
        UIView.animateWithDuration(kAnimationDuration + 0.1, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in
            
            backWindow?.rootViewController?.view.layer.transform = CATransform3DScale(CATransform3DIdentity, kTransform , kTransform , 1);
            backWindow?.rootViewController?.view.alpha = kAlphe
            
            self.transform = CGAffineTransformIdentity;
            
            self.frame = UIScreen.mainScreen().bounds;
            }, completion: { (finished: Bool) -> Void in
                self.removeTapGestureToClose()
        })
    }
    
    // MARK: Tap Gesture
    private func addTapGestureToClose(){
        
        if let tap = tapGesture{
            addGestureRecognizer(tap)
        }
        else{
            tapGesture = UITapGestureRecognizer(target: self, action: "handleTapGesture:")
            addGestureRecognizer(tapGesture!)
        }
    }
    
    private func removeTapGestureToClose(){
        
        if let tap = tapGesture{
            removeGestureRecognizer(tap)
        }
    }
}