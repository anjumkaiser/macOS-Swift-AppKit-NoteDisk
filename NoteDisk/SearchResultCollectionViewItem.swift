//
//  SearchResultCollectionViewItem.swift
//  NoteDisk
//
//  Created by Muhammad Anjum Kaiser on 23/11/2021.
//

import Cocoa

class SearchResultCollectionViewItem: NSCollectionViewItem {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.wantsLayer = true
        view.layer?.borderWidth = 0.0
        view.layer?.borderColor = NSColor.highlightColor.cgColor
    }
    
    func setHighlight(selected: Bool) {
        view.layer?.borderWidth = selected ? 0.5 : 0.0
    }
}
