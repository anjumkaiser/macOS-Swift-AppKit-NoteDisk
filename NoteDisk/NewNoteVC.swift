//
//  NewNoteVC.swift
//  NoteDisk
//
//  Created by Muhammad Anjum Kaiser on 17/11/2021.
//

import Cocoa

class NewNoteVC: NSViewController {
    
    @IBOutlet weak var noteTextField: NSTextField!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        NSApp.setActivationPolicy(.regular)
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        NSApp.setActivationPolicy(.accessory)
    }
    
    @IBAction func closeButton_Clicked(_ sender: Any) {
        self.view.window?.orderOut(self)
    }
    
    @IBAction func postButton_Clicked(_ sender: Any) {
    }
    
}
