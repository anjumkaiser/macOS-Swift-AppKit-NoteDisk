//
//  SignInVC.swift
//  NoteDisk
//
//  Created by Muhammad Anjum Kaiser on 16/11/2021.
//

import Cocoa

enum SignInMode {
    case SignIn
    case SignUp
}

class SignInVC: NSViewController {
    
    @IBOutlet weak var signInButton: NSButton!
    @IBOutlet weak var cancelButton: NSButtonCell!
    
    var mode: SignInMode = .SignIn
    
    private static let SIGN_IN_TEXT = "Sign In"
    private static let SIGN_UP_TEXT = "Sign Up"
    
    
    override func viewWillAppear() {
        super.viewWillAppear()
        NSApp.setActivationPolicy(.regular)
        
        if mode == .SignIn {
            signInButton.title = SignInVC.SIGN_IN_TEXT
            view.window?.title = SignInVC.SIGN_IN_TEXT
        } else {
            signInButton.title = SignInVC.SIGN_UP_TEXT
            view.window?.title = SignInVC.SIGN_UP_TEXT
        }
        
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        NSApp.setActivationPolicy(.accessory)
    }
    @IBAction func cancelButton_Clicked(_ sender: Any) {
        self.view.window?.orderOut(self)
    }
}
