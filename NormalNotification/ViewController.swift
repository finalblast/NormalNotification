//
//  ViewController.swift
//  NormalNotification
//
//  Created by Nam (Nick) N. HUYNH on 3/29/16.
//  Copyright (c) 2016 Enclave. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textField: UITextField!
    
    func orientationChanged(notification: NSNotification) {
        
        println("Orientation changed!")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "orientationChanged:", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIDeviceOrientationDidChangeNotification, object: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.contentInset = UIEdgeInsetsZero
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "handleKeyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: "handleKeyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    func handleKeyboardWillShow(notification: NSNotification) {
        
        let userInfo = notification.userInfo
        if let info = userInfo {
            
            let animationDurationObject = info[UIKeyboardAnimationDurationUserInfoKey] as NSValue
            let keyboardEndRectObject = info[UIKeyboardFrameEndUserInfoKey] as NSValue
            var animationDuration = 0.0
            var keyboardEndRect = CGRectZero
            
            animationDurationObject.getValue(&animationDuration)
            keyboardEndRectObject.getValue(&keyboardEndRect)
            
            let window = UIApplication.sharedApplication().keyWindow
            keyboardEndRect = view.convertRect(keyboardEndRect, fromView: window)
            let intersectionOfKeyboardRectAndWindowRect = CGRectIntersection(view.frame, keyboardEndRect)
            
            UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                
                self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, intersectionOfKeyboardRectAndWindowRect.size.height, 0)
                self.scrollView.scrollRectToVisible(self.textField.frame, animated: false)
                
            })
            
        }
        
    }
    
    func handleKeyboardWillHide(notification: NSNotification) {
        
        let userInfo = notification.userInfo
        if let info = userInfo {
            
            let animationDurationObject = info[UIKeyboardAnimationDurationUserInfoKey] as NSValue
            var animationDuration = 0.0
            animationDurationObject.getValue(&animationDuration)
            UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                
                self.scrollView.contentInset = UIEdgeInsetsZero
                
            })
            
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

