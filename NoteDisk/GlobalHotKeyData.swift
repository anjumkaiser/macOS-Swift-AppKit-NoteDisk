//
//  GlobalHotKeyData.swift
//  NoteDisk
//
//  Created by Muhammad Anjum Kaiser on 15/11/2021.
//

import Foundation

struct GlobalHotKeyData: Codable, CustomStringConvertible {
    let function: Bool
    let control: Bool
    let option: Bool
    let command: Bool
    let shift: Bool
    let capslock: Bool
    
    let carbonFlags: UInt32
    let keyCode: UInt32
    
    let characters: String?
    
    var description: String {
        var keyArray: [String] = []
        
        if function == true {
            keyArray.append("Fn ")
        }
        
        if control == true {
            keyArray.append("⌃")
        }

        if option == true {
            keyArray.append("⌥")
        }
        
        if command == true {
            keyArray.append("⌘")
        }
        
        if shift == true {
            keyArray.append("⇧")
        }
        
        if capslock == true {
            keyArray.append("⇪")
        }
        
        if let chars = self.characters {
            keyArray.append(chars.uppercased())
        }
        
        return keyArray.joined(separator: "")
    }
}
