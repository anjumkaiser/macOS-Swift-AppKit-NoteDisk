//
//  StatusBarController.swift
//  NoteDisk
//
//  Created by Muhammad Anjum Kaiser on 08/11/2021.
//

import AppKit

class StatusBarController {
    private var statusBar: NSStatusBar
    private var statusItem: NSStatusItem
    private var popover: NSPopover
    
    init(_ popover: NSPopover) {
        self.popover = popover
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
        
    }
    
    @objc func signInAction(_ sender: AnyObject) {
        
    }
    
    @objc func newNoteAction(_ sender: AnyObject) {
        
    }
    
    @objc func preferencesAction(_ sender: AnyObject) {
        
    }
    
    @objc func quitAction(_ sender: AnyObject) {
        NSApplication.shared.terminate(nil)
    }
}
