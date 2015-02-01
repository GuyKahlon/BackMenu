//
//  AppDelegate.swift
//  BackMenu
//
//  Created by Guy Kahlon on 1/25/15.
//  Copyright (c) 2015 GuyKahlon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var frontWindow: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let front:UIViewController =  storyboard.instantiateViewControllerWithIdentifier("frontViewController") as UIViewController
        frontWindow = UIWindow(frame: UIScreen.mainScreen().bounds)
        frontWindow?.rootViewController = front;
        frontWindow?.windowLevel = UIWindowLevelStatusBar
        frontWindow?.startSwipeToOpenMenu()
        frontWindow?.makeKeyAndVisible();
        
//        frontWindow?.layer.masksToBounds = true
//        let maskPath = UIBezierPath(roundedRect: UIScreen.mainScreen().bounds, byRoundingCorners: (.TopLeft | .TopRight), cornerRadii: CGSizeMake(2.0, 2.0))
//        let maskLayer = CAShapeLayer()
//        maskLayer.frame = UIScreen.mainScreen().bounds
//        maskLayer.path = maskPath.CGPath;
//        frontWindow?.layer.mask = maskLayer;
        
        
        
        application.setStatusBarStyle(.LightContent, animated:false)
        return true
    }
}

