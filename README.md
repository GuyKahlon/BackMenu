# BackMenu
This is a simple iOS menu control inspired by Creative Labs applications of Facebook (Paper, Slingshot, Groups).

![alt tag](https://github.com/GuyKahlon/BackMenu/blob/master/DemoGif.gif)


# How To Get Started
* Download BackMenu and try out the iPhone example apps.

# Usage
Copy the ExtensionWindow file.
You should create two optional value of UIWindows in the appDelegate class.

    var window: UIWindow?
    var frontWindow: UIWindow?
    
The 'Storyboatd Entry Point' is the Back window (You can also initialize the window manually if you want).

The secound window is the front window, and we initialize it menualy.
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
    
Please note: There is also the method: stopSwipeToOpenMenu() in extension UIWindow class, Call to this method when you want to disable the menu.

# Contact
Follow me on Twitter (@guykahlon)

# License
BackMenu is available under the MIT license. See the LICENSE file for more info.
