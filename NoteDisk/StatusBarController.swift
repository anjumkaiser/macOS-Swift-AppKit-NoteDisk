//
//  StatusBarController.swift
//  NoteDisk
//
//  Created by Muhammad Anjum Kaiser on 08/11/2021.
//

import AppKit
import HotKey

class StatusBarController {
    private var statusBar: NSStatusBar
    private var statusItem: NSStatusItem
    private var popover: NSPopover
    
    private var preferencesWC: PreferencesWC?
    
    init() {
        // Set the SwiftUI's ContentView to the Popover's ContentViewController
        popover = NSPopover()
        popover.contentSize = NSSize(width: 360, height: 360)
        popover.behavior = .transient
        statusBar = NSStatusBar()
        
        // Creating a status bar item having a fixed length
        statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)

        
        if let statusBarButton = statusItem.button {
            statusBarButton.image = NSImage(named: "SystemMenuIcon")
            statusBarButton.image?.size = NSSize(width: 18.0, height: 18.0)
            statusBarButton.image?.isTemplate = true
            
            statusBarButton.action = #selector(togglePopover(sender:))
            statusBarButton.target = self
        }
        
        constructMenu()
        
        if let openNoteHotKeyConfig = Configuration.shared.openNoteHotKey {
            openNoteHotKey = HotKey(keyCombo: KeyCombo(carbonKeyCode: openNoteHotKeyConfig.keyCode, carbonModifiers: openNoteHotKeyConfig.carbonFlags))
        }
        
        if let searchHotKeyConfig = Configuration.shared.searchHotKey {
            searchHotKey = HotKey(keyCombo: KeyCombo(carbonKeyCode: searchHotKeyConfig.keyCode, carbonModifiers: searchHotKeyConfig.carbonFlags))
        }

    }
    
    func constructMenu() {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Sign Up", action: #selector(self.signUpAction(_:)), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Sign In", action: #selector(self.signInAction(_:)), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "New Note", action: #selector(self.newNoteAction(_:)), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Preferences", action: #selector(self.preferencesAction(_:)), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(self.quitAction(_:)), keyEquivalent: "q"))
        
        for mi in menu.items {
            if mi.title != ""  {
                mi.target = self
            }
        }
        
        statusItem.menu = menu
    }
    
    @objc func togglePopover(sender: AnyObject) {
        if(popover.isShown) {
            hidePopover(sender)
        }
        else {
            showPopover(sender)
        }
    }
    
    func showPopover(_ sender: AnyObject) {
        if let statusBarButton = statusItem.button {
            popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: NSRectEdge.maxY)
        }
    }
    
    func hidePopover(_ sender: AnyObject) {
        popover.performClose(sender)
    }
    
    @objc func signUpAction(_ sender: AnyObject) {
        
    }
    
    @objc func signInAction(_ sender: AnyObject) {
        
    }
    
    @objc func newNoteAction(_ sender: AnyObject) {
        
    }
    
    @objc func preferencesAction(_ sender: AnyObject) {
        
        if preferencesWC == nil {
            preferencesWC = NSStoryboard.main?.instantiateController(withIdentifier: "preferencesWCID") as? PreferencesWC
        }
        preferencesWC?.showWindow(nil)
        
    }
    
    @objc func quitAction(_ sender: AnyObject) {
        NSApplication.shared.terminate(nil)
    }
    
    var openNoteHotKey: HotKey? {
        didSet {
            guard let openNoteHotKey = openNoteHotKey else {
                return
            }
            
            openNoteHotKey.keyDownHandler = { [weak self] in
                print("open note hotkey pressed")
            }
        }
    }
    
    var searchHotKey: HotKey? {
        didSet {
            guard let searchHotKey = searchHotKey else {
                return
            }
            
            searchHotKey.keyDownHandler = { [weak self] in
                print("search hotkey pressed")
            }

        }
    }
}
