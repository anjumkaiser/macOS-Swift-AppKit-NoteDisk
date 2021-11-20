//
//  SearchVC.swift
//  NoteDisk
//
//  Created by Muhammad Anjum Kaiser on 20/11/2021.
//

import Cocoa

class SearchVC: NSViewController {
    
    var searchString: String = ""
    
    @IBOutlet weak var searchStringTextField: NSTextField!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        NSApp.setActivationPolicy(.regular)
        searchStringTextField.stringValue = self.searchString
        self.view.window?.makeKeyAndOrderFront(self)
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        NSApp.setActivationPolicy(.accessory)
    }
    
}
