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
    fileprivate var grabKey: KeyToGrab = .None
    
    override func viewDidLoad() {
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
            self.keyDown(with: $0)
            return $0
        }
    }
    
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
    
    override func keyDown(with event: NSEvent) {
        if grabKey == .None {
            return
        }
        
        grabKey = KeyToGrab.None
    }
    
    @IBAction func configureOpenNoteHotKeyButton_Clicked(_ sender: Any) {
        grabKey = .OpenNote
    }
    
    @IBAction func configureSearchHotKeyButton_clicked(_ sender: Any) {
        grabKey = .Search
    }
}


fileprivate enum KeyToGrab {
    case None
    case OpenNote
    case Search
}
