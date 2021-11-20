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
    private var signInWC: SignInWC?
    private var newNoteWC: NewNoteWC?
    private var searchWC: SearchWC?
    
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
        if signInWC == nil {
            signInWC = NSStoryboard.main?.instantiateController(withIdentifier: "signInWCID") as? SignInWC
        }
        signInWC?.window?.orderOut(self)
        (signInWC?.contentViewController as? SignInVC)?.mode = .SignUp
        signInWC?.showWindow(self)
    }
    
    @objc func signInAction(_ sender: AnyObject) {
        if signInWC == nil {
            signInWC = NSStoryboard.main?.instantiateController(withIdentifier: "signInWCID") as? SignInWC
        }
        signInWC?.window?.orderOut(self)
        (signInWC?.contentViewController as? SignInVC)?.mode = .SignIn
        signInWC?.showWindow(self)
    }
    
    @objc func newNoteAction(_ sender: AnyObject) {
        if newNoteWC == nil {
            newNoteWC = NSStoryboard.main?.instantiateController(withIdentifier: "newNoteWCID") as? NewNoteWC
        }
        newNoteWC?.showWindow(nil)
    }
    
    @objc func preferencesAction(_ sender: AnyObject) {
        
        if preferencesWC == nil {
            preferencesWC = NSStoryboard.main?.instantiateController(withIdentifier: "preferencesWCID") as? PreferencesWC
        }
        preferencesWC?.showWindow(nil)
        
    }
    
    @objc func searchAction(_ sender: AnyObject, searchString: String = "") {
        if searchWC == nil {
            searchWC = NSStoryboard.main?.instantiateController(withIdentifier: "searchWCID") as? SearchWC
        }
        
        (searchWC?.contentViewController as? SearchVC)?.searchString = searchString
        searchWC?.showWindow(nil)
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
                self?.newNoteAction(NSApplication.shared.self)
            }
        }
    }
    
    var searchHotKey: HotKey? {
        didSet {
            guard let searchHotKey = searchHotKey else {
                return
            }
            
            searchHotKey.keyDownHandler = { [weak self] in
                let searchString: String = "asdf"
                self?.searchAction(NSApplication.shared.self, searchString: searchString)
            }

        }
    }
    
    func closeSignInWindow() {
        signInWC?.window?.orderOut(self)
    }
    
    func closeNoteWindow() {
        self.newNoteWC?.window?.orderOut(self)
    }
}
