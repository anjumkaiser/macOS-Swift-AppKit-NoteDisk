//
//  AppDelegate.swift
//  NoteDisk
//
//  Created by Muhammad Anjum Kaiser on 08/11/2021.
//

import Cocoa
import HotKey

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusBarController: StatusBarController!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        //Initialising the status bar
        statusBarController = StatusBarController()
        
        if let openNoteHotKeyConfig = Configuration.shared.openNoteHotKey {
            statusBarController.openNoteHotKey = HotKey(keyCombo: KeyCombo(carbonKeyCode: openNoteHotKeyConfig.keyCode, carbonModifiers: openNoteHotKeyConfig.carbonFlags))
        }

        if let searchHotKeyConfig = Configuration.shared.searchHotKey {
            statusBarController.searchHotKey = HotKey(keyCombo: KeyCombo(carbonKeyCode: searchHotKeyConfig.keyCode, carbonModifiers: searchHotKeyConfig.carbonFlags))
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

