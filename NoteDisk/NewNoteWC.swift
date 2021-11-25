//
//  NewNoteWC.swift
//  NoteDisk
//
//  Created by Muhammad Anjum Kaiser on 17/11/2021.
//

import Cocoa

class NewNoteWC: NSWindowController {
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.configuraWindowAppearance()
    }
    
    
    func configuraWindowAppearance() {
        guard let window = window else { return }
        window.level = .mainMenu
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        window.backingType = .buffered
    }
    
}
