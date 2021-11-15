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
    
    private static let OPEN_NOTE_HOTHEY_KEY = "OpenNoteHotKey"
    private static let SEARCH_HOTHEY_KEY = "SearchHotKey"
    
    var openNoteHotKey: GlobalHotKeyData? {
        set {
            UserDefaults.standard.setValue(try? PropertyListEncoder().encode(newValue), forKey: Configuration.OPEN_NOTE_HOTHEY_KEY)
        }
        get {
            if let data = UserDefaults.standard.value(forKey: Configuration.OPEN_NOTE_HOTHEY_KEY) as? Data {
                let x = try? PropertyListDecoder().decode(GlobalHotKeyData.self, from: data)
                return x
            }
            return nil
        }
    }
    
    var searchHotKey: GlobalHotKeyData? {
        set {
            UserDefaults.standard.setValue(try? PropertyListEncoder().encode(newValue), forKey: Configuration.SEARCH_HOTHEY_KEY)
        }
        get {
            if let data = UserDefaults.standard.value(forKey: Configuration.SEARCH_HOTHEY_KEY) as? Data {
                let x = try? PropertyListDecoder().decode(GlobalHotKeyData.self, from: data)
                return x
            }
            return nil
        }
    }
}
