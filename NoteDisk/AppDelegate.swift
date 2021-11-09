//
//  AppDelegate.swift
//  NoteDisk
//
//  Created by Muhammad Anjum Kaiser on 08/11/2021.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusBarController: StatusBarController!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        //Initialising the status bar
        statusBarController = StatusBarController()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

