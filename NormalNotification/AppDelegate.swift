//
//  AppDelegate.swift
//  NormalNotification
//
//  Created by Nam (Nick) N. HUYNH on 3/29/16.
//  Copyright (c) 2016 Enclave. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    class func notificationName() -> String {
    
        return "SetPersonInfoNitification"
        
    }
    
    class func personInfoKeyFirstName() -> String {
    
        return "firstName"
        
    }
    
    class func personInfoKeyLastName() -> String {
    
        return "lastName"
        
    }
    
    func handleSettingChanged(notification: NSNotification) {
        
        println("Setting changed!")
        
        if let object: AnyObject = notification.object {
            
            println("Notification Object: \(object)")
            
        }
        
    }
    
    func scheduleNotification() {
        
        let notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: 8)
        notification.timeZone = NSCalendar.currentCalendar().timeZone
        notification.alertBody = "A new item is downloaded"
        
        notification.hasAction = true
        notification.alertAction = "View"
        
        notification.applicationIconBadgeNumber++
        notification.userInfo = [
            
            "Key 1": "Value 1",
            "Key 2": "Value 2"
            
        ]
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
    
    func askForNotificationPermission(application: UIApplication) {
        
        let setting = UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Badge, categories: nil)
        application.registerUserNotificationSettings(setting)
        
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let steveJobs = Person()
        
        if let options = launchOptions {
            
            let value = options[UIApplicationLaunchOptionsLocalNotificationKey] as? UILocalNotification
            if let notification = value {
                
                self.application(application, didReceiveLocalNotification: notification)
                
            }
            
        } else {
            
            askForNotificationPermission(application)
            
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleSettingChanged:", name: NSUserDefaultsDidChangeNotification, object: nil)
        
        let userInfo = [
        
            self.classForCoder.personInfoKeyFirstName() : "Steve",
            self.classForCoder.personInfoKeyLastName() : "Jobs"
            
        ]
        
        let notification = NSNotification(name: self.classForCoder.notificationName(), object: self, userInfo: userInfo)
        
        NSNotificationCenter.defaultCenter().postNotification(notification)
        if let firstName = steveJobs.firstName {
            
            println("Person's first name is: \(firstName)")
            
        }
        if let lastName = steveJobs.lastName {
            
            println("Person's last name is: \(lastName)")
            
        }
        
        return true
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        
        let key1Value = notification.userInfo!["Key 1"] as? String
        let key2Value = notification.userInfo!["Key 2"] as? String
        
        if key1Value != nil && key2Value != nil {
            
            
            
        } else {
            
            
            
        }
        
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        
        if notificationSettings.types == nil {
            
            return
            
        }
        
        scheduleNotification()
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

