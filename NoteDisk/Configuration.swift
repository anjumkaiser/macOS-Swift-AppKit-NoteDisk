//
//  Configuration.swift
//  NoteDisk
//
//  Created by Muhammad Anjum Kaiser on 11/11/2021.
//

import Foundation


class Configuration {
    
    static var shared: Configuration = Configuration()
    
    private init() {
    }
    
    private let OPEN_NOTE_HOTHEY_KEY = "OpenNoteHotKey"
    private let SEARCH_HOTHEY_KEY = "SearchHotKey"
    
    var openNoteHotKey: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: OPEN_NOTE_HOTHEY_KEY)
        }
        get {
            return UserDefaults.standard.string(forKey: OPEN_NOTE_HOTHEY_KEY)
        }
    }
    
    var searchHotKey: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: SEARCH_HOTHEY_KEY)
        }
        get {
            return UserDefaults.standard.string(forKey: SEARCH_HOTHEY_KEY)
        }
    }
}
