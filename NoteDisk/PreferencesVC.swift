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
        
        if let characters = event.charactersIgnoringModifiers {
            let globalkeyData = GlobalHotKeyData(
                function: event.modifierFlags.intersection(.deviceIndependentFlagsMask).contains(.function),
                control: event.modifierFlags.intersection(.deviceIndependentFlagsMask).contains(.control),
                option: event.modifierFlags.intersection(.deviceIndependentFlagsMask).contains(.option),
                command: event.modifierFlags.intersection(.deviceIndependentFlagsMask).contains(.command),
                shift: event.modifierFlags.intersection(.deviceIndependentFlagsMask).contains(.shift),
                capslock: event.modifierFlags.intersection(.deviceIndependentFlagsMask).contains(.capsLock),
                carbonFlags: event.modifierFlags.carbonFlags,
                keyCode: UInt32(event.keyCode),
                characters: characters)
            let keyString = globalkeyData.description
            let appDelegate = NSApplication.shared.delegate as? AppDelegate
            if grabKey == .OpenNote {
                appDelegate?.statusBarController.openNoteHotKey = HotKey(keyCombo: KeyCombo(carbonKeyCode: globalkeyData.keyCode, carbonModifiers: globalkeyData.carbonFlags))
                self.configureOpenNoteHotKeyButton.title = keyString
                self.configureOpenNoteHotKeyButton.highlight(false)
            } else if grabKey == .Search {
                appDelegate?.statusBarController.searchHotKey = HotKey(keyCombo: KeyCombo(carbonKeyCode: globalkeyData.keyCode, carbonModifiers: globalkeyData.carbonFlags))
                self.configureSearchHotKeyButton.title = keyString
                self.configureSearchHotKeyButton.highlight(false)
            }
            grabKey = KeyToGrab.None
        }
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
