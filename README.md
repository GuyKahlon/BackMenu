# BackMenu
This is a simple iOS menu control inspired by Creative Labs applications of Facebook (Paper, Slingshot, Groups).

![alt tag](https://github.com/GuyKahlon/BackMenu/blob/master/DemoGif.gif)


# How To Use
We should create two windows optional value in the appDelegate class.

    var window: UIWindow?
    var frontWindow: UIWindow?
    
The 'Storyboatd Entry Point' is the Back window.
The secound window is the front, and we initialize it menualy.
For example:

    let front:UIViewController =  storyboard.instantiateViewControllerWithIdentifier("frontViewController") as UIViewController
    frontWindow = UIWindow(frame: UIScreen.mainScreen().bounds)
    frontWindow?.rootViewController = front;

Three more important things:
1. Change the window Level
2. Call to: startSwipeToOpenMenu() 
3. Call to: makeKeyAndVisible();

    frontWindow?.windowLevel = UIWindowLevelStatusBar
    frontWindow?.startSwipeToOpenMenu()
    frontWindow?.makeKeyAndVisible();
    
Please note: There is also the method: stopSwipeToOpenMenu() in extension UIWindow class.
