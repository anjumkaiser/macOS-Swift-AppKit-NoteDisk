//
//  AppDelegate.swift
//  NoteDisk
//
//  Created by Muhammad Anjum Kaiser on 08/11/2021.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var popover: NSPopover!
    var statusBarController: StatusBarController!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        // Set the SwiftUI's ContentView to the Popover's ContentViewController
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 360, height: 360)
        popover.behavior = .transient
        //popover.contentViewController = NSHostingController(rootView: contentView)
        self.popover = popover
        
        //Initialising the status bar
        statusBarController = StatusBarController(popover)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

