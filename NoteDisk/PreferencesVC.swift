//
//  PreferencesVC.swift
//  NoteDisk
//
//  Created by Muhammad Anjum Kaiser on 11/11/2021.
//

import Cocoa

class PreferencesVC : ViewController {
    
    @IBOutlet weak var configureOpenNoteHotKeyButton: NSButton!
    @IBOutlet weak var configureSearchHotKeyButton: NSButton!
    
    private let CLICK_TO_SET_MSG: String = "Click to set"
    
    override func viewWillAppear() {
        super.viewWillAppear()
        NSApp.setActivationPolicy(.regular)
        
        configureOpenNoteHotKeyButton.title = Configuration.shared.openNoteHotKey ?? CLICK_TO_SET_MSG
        configureSearchHotKeyButton.title = Configuration.shared.searchHotKey ?? CLICK_TO_SET_MSG
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        NSApp.setActivationPolicy(.accessory)
    }
    
    
    @IBAction func configureOpenNoteHotKeyButton_Clicked(_ sender: Any) {
    }
    
    @IBAction func configureSearchHotKeyButton_clicked(_ sender: Any) {
    }
}
