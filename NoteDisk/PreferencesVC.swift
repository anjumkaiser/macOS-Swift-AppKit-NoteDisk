//
//  PreferencesVC.swift
//  NoteDisk
//
//  Created by Muhammad Anjum Kaiser on 11/11/2021.
//

import Cocoa
import Carbon
import HotKey

class PreferencesVC : NSViewController {
    
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
        
        var commandKey: Bool = false
        var optionKey: Bool = false
        var ctrlKey: Bool = false
        var shiftKey: Bool = false
        var capsLockKey: Bool = false
        var functionKey: Bool = false
        
        guard let eventChars = event.characters else {
            return
        }
        
        var keyArray: [String] = []
        if event.modifierFlags.intersection(.deviceIndependentFlagsMask).contains(.command) {
            commandKey = true
            keyArray.append("⌘")
        }
        
        if event.modifierFlags.intersection(.deviceIndependentFlagsMask).contains(.option) {
            optionKey = true
            keyArray.append("⌥")
        }
        
        if event.modifierFlags.intersection(.deviceIndependentFlagsMask).contains(.control) {
            ctrlKey = true
            keyArray.append("⌃")
        }
        
        if event.modifierFlags.intersection(.deviceIndependentFlagsMask).contains(.shift) {
            shiftKey = true
            keyArray.append("⇧")
        }
        
        if event.modifierFlags.intersection(.deviceIndependentFlagsMask).contains(.capsLock) {
            capsLockKey = true
            keyArray.append("⇪")
        }
        
        if event.modifierFlags.intersection(.deviceIndependentFlagsMask).contains(.function) {
            functionKey = true
            keyArray.append("Fn ")
        }
        
        if eventChars == " " {
            keyArray.append("[Space]")
        } else {
            keyArray.append("\(eventChars)")
        }
        //keyString = keyString.trimmingCharacters(in: CharacterSet.whitespaces)
        let keyString = keyArray.joined(separator: "").uppercased()
        let appDelegate = NSApplication.shared.delegate as? AppDelegate
        
        print("key code is [\(event.keyCode)] modifiers: [cmd: \(commandKey) opt: \(optionKey) ctrl: \(ctrlKey) shift: \(shiftKey) caps: \(capsLockKey) fn: \(functionKey)]")
        
        if grabKey == .OpenNote {
            appDelegate?.statusBarController.openNoteHotKey = HotKey(keyCombo: KeyCombo(carbonKeyCode: UInt32(event.keyCode), carbonModifiers: event.modifierFlags.carbonFlags))
            self.configureOpenNoteHotKeyButton.title = keyString
            self.configureOpenNoteHotKeyButton.highlight(false)
        } else if grabKey == .Search {
            appDelegate?.statusBarController.searchHotKey = HotKey(keyCombo: KeyCombo(carbonKeyCode: UInt32(event.keyCode), carbonModifiers: event.modifierFlags.carbonFlags))
            self.configureSearchHotKeyButton.title = keyString
            self.configureSearchHotKeyButton.highlight(false)
        }
        
        grabKey = KeyToGrab.None
    }
    
    @IBAction func configureOpenNoteHotKeyButton_Clicked(_ sender: Any) {
        grabKey = .OpenNote
        self.configureOpenNoteHotKeyButton.highlight(true)
    }
    
    @IBAction func configureSearchHotKeyButton_clicked(_ sender: Any) {
        grabKey = .Search
        self.configureSearchHotKeyButton.highlight(true)
    }
}


fileprivate enum KeyToGrab {
    case None
    case OpenNote
    case Search
}
