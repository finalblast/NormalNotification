//
//  Person.swift
//  FileManagement
//
//  Created by Nam (Nick) N. HUYNH on 3/28/16.
//  Copyright (c) 2016 Enclave. All rights reserved.
//

import UIKit

class Person: NSObject {
    
    var firstName: String?
    var lastName: String?
    
    struct SerializationKey {
    
        static let firstName = "firstName"
        static let lastName = "lastName"
        
    }
    
    override init() {
        
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleSetPersonInfoNotification:", name: AppDelegate.notificationName(), object: UIApplication.sharedApplication().delegate)
        
    }
    
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    
    func handleSetPersonInfoNotification(notification: NSNotification) {
        
        firstName = notification.userInfo![AppDelegate.personInfoKeyFirstName()] as? String
        lastName = notification.userInfo![AppDelegate.personInfoKeyLastName()] as? String
        
    }
    
}

extension Person: Equatable{}

func == (lhs: Person, rhs: Person) -> Bool{
    
    return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName ? true : false
    
}
