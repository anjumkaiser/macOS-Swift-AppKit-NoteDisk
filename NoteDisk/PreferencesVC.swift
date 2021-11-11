//
//  PreferencesVC.swift
//  NoteDisk
//
//  Created by Muhammad Anjum Kaiser on 11/11/2021.
//

import Cocoa

class PreferencesVC : ViewController {
    override func viewWillAppear() {
        NSApp.setActivationPolicy(.regular)
    }
    
    override func viewWillDisappear() {
        NSApp.setActivationPolicy(.accessory)
    }
}
