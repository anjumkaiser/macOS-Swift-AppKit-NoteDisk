//
//  SearchVC.swift
//  NoteDisk
//
//  Created by Muhammad Anjum Kaiser on 20/11/2021.
//

import Cocoa
import Carbon.HIToolbox

class SearchVC: NSViewController {
    
    var searchString: String = ""
    
    @IBOutlet weak var searchStringTextField: NSTextField!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        NSApp.setActivationPolicy(.regular)
        searchStringTextField.stringValue = self.searchString
        self.view.window?.makeKeyAndOrderFront(self)
        
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
            self.keyDown(with: $0)
            return $0
        }
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        NSApp.setActivationPolicy(.accessory)
    }
    
    override func keyDown(with event: NSEvent) {
        if event.keyCode == kVK_Escape {
            self.view.window?.orderOut(self)
            return
        } else if event.keyCode == kVK_Return {
            doSearchString()
            return
        }
        super.keyDown(with: event)
    }
    
    func doSearchString() {
        
    }
}
