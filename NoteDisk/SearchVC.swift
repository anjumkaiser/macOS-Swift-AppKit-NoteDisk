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
    
    private var searchResult : [String] = [String]()
    
    @IBOutlet weak var searchStringTextField: NSTextField!
    @IBOutlet weak var searchResultsCollectionView: NSCollectionView!
    
    let searchResultCollectionViewItemIdentifer: NSUserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier(rawValue: "searchResultCollectionViewItemID")
    
    override func viewWillAppear() {
        super.viewWillAppear()
        searchResultsCollectionView.dataSource = self
        searchResultsCollectionView.delegate = self
        if let nibName = NSNib(nibNamed: "SearchResultCollectionViewItem", bundle: nil) {
            searchResultsCollectionView.register(nibName, forItemWithIdentifier: searchResultCollectionViewItemIdentifer)
        }
        NSApp.setActivationPolicy(.regular)
        self.view.window?.makeKeyAndOrderFront(self)
        
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
            self.keyDown(with: $0)
            return $0
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
        } else if event.keyCode == kVK_Return {
            doSearchString()
            return
        }
        super.keyDown(with: event)
    }
    
    func doSearchString() {
        var urlRequest: URLRequest
        urlRequest = URLRequest(url: URL(string: SearchVC.SEARCH_URL_TEXT)!)
        let searchData: SearchData = SearchData(token: Configuration.shared.token, query: searchStringTextField.stringValue)
        
        urlRequest.method = .post
        urlRequest.setValue("appleication/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("appleication/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        let encodedData = try? JSONEncoder().encode(searchData)
        urlRequest.httpBody = encodedData
        
        AF.request(urlRequest).responseJSON { (response) in            
            self.searchResult.removeAll()
            
            if response.error != nil {
                print("error is \(String(describing: response.error))")
                print("Unable to connect")
                return
            }
            
            guard let respData: [String] = try? JSONDecoder().decode([String].self, from: response.data!) else {
                return
            }
            
            if respData.count < 1 {
                return
            }
            
            self.searchResult = respData
        }
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
        guard let firstItem = indexPaths.first else {
            return
        }
        
        print("Selected \(self.searchResult[firstItem.item])")
    }
    
}
