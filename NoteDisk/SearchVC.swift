//
//  SearchVC.swift
//  NoteDisk
//
//  Created by Muhammad Anjum Kaiser on 20/11/2021.
//

import Cocoa
import Carbon.HIToolbox
import Alamofire

class SearchVC: NSViewController {
    
    private static let SEARCH_URL_TEXT = "http://64.227.33.185:8080/api/search"
    private static let ERROR_TEXT = "ERROR"
    
    private var searchResult : [String] = [String]()
    
    @IBOutlet weak var searchStringTextField: NSTextField!
    @IBOutlet weak var searchResultsCollectionView: NSCollectionView!
    
    let searchResultCollectionViewItemIdentifer: NSUserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier(rawValue: "searchResultCollectionViewItemID")
    
    override func viewWillAppear() {
        super.viewWillAppear()
        searchStringTextField.stringValue = NSPasteboard.general.pasteboardItems?.first?.string(forType: .string) ?? ""
        searchResult.removeAll()
        searchResultsCollectionView.dataSource = self
        searchResultsCollectionView.delegate = self
        if let nibName = NSNib(nibNamed: "SearchResultCollectionViewItem", bundle: nil) {
            searchResultsCollectionView.register(nibName, forItemWithIdentifier: searchResultCollectionViewItemIdentifer)
        }
        NSApp.setActivationPolicy(.regular)
        
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
            self.keyDown(with: $0)
            return $0
        }
    }
    
    override func viewDidAppear() {
        if searchStringTextField.stringValue != "" {
            doSearchString()
        } else {
            searchResultsCollectionView.reloadData()
        }
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        NSApp.setActivationPolicy(.accessory)
    }
    
    override func keyDown(with event: NSEvent) {
        if event.keyCode == kVK_Escape {
            self.view.window?.orderOut(self)
            return
        } else {
            doSearchString()
        }
    }
    
    func doSearchString() {
        var urlRequest: URLRequest
        urlRequest = URLRequest(url: URL(string: SearchVC.SEARCH_URL_TEXT)!)
        urlRequest.method = .post
        urlRequest.setValue("appleication/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("appleication/json", forHTTPHeaderField: "Accept")
        
        let searchData: SearchData = SearchData(token: Configuration.shared.token, query: searchStringTextField.stringValue)
        
        let encodedData = try? JSONEncoder().encode(searchData)
        urlRequest.httpBody = encodedData
        
        AF.request(urlRequest).responseJSON { (response) in            
            self.searchResult.removeAll()
            
            if response.error != nil {
                print("error is \(String(describing: response.error))")
                //self.showAlert(title: SearchVC.ERROR_TEXT, message: "Unable to connect")
                return
            }
            
            guard let respData: [String] = try? JSONDecoder().decode([String].self, from: response.data!) else {
                //self.showAlert(title: SearchVC.ERROR_TEXT, message: "Invalid response")
                return
            }
            
            if respData.count < 1 {
                return
            }
            
            self.searchResult = respData
            self.searchResultsCollectionView.reloadData()
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = NSAlert()
        alert.messageText = message
        alert.informativeText = title
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.beginSheetModal(for: self.view.window!)
    }
}

fileprivate struct SearchData: Codable {
    let token: String
    let query: String
}


extension SearchVC: NSCollectionViewDataSource {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.searchResult.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let item = collectionView.makeItem(withIdentifier: searchResultCollectionViewItemIdentifer, for: indexPath)
        item.textField?.stringValue = self.searchResult[indexPath.item]
        return item
        
    }
    
}


extension SearchVC: NSCollectionViewDelegate {
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        guard let firstItem = indexPaths.first else { return }
        guard let selectedItem = searchResultsCollectionView.item(at: firstItem) else { return }
        (selectedItem as? SearchResultCollectionViewItem)?.setHighlight(selected: true)
        
        print("Selected \(self.searchResult[firstItem.item])")
    }
    
    
    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        guard let firstItem = indexPaths.first else { return }
        guard let selectedItem = searchResultsCollectionView.item(at: firstItem) else { return }
        (selectedItem as? SearchResultCollectionViewItem)?.setHighlight(selected: false)
    }

}

extension SearchVC: NSCollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt: IndexPath) -> NSSize {
        
        return NSSize(width: parent?.view.visibleRect.width ?? 438, height: 16.0)
    }
    
}
