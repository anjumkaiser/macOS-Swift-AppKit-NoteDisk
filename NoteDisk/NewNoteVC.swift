//
//  NewNoteVC.swift
//  NoteDisk
//
//  Created by Muhammad Anjum Kaiser on 17/11/2021.
//

import Cocoa
import Alamofire

class NewNoteVC: NSViewController {
    
    @IBOutlet weak var noteTextField: NSTextField!
    
    private static let POST_URL_TEXT = "http://64.227.33.185:8080/api/post"
    
    override func viewWillAppear() {
        super.viewWillAppear()
        NSApp.setActivationPolicy(.regular)
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        NSApp.setActivationPolicy(.accessory)
    }
    
    @IBAction func closeButton_Clicked(_ sender: Any) {
        self.view.window?.orderOut(self)
    }
    
    @IBAction func postButton_Clicked(_ sender: Any) {
        var urlRequest: URLRequest
        urlRequest = URLRequest(url: URL(string: NewNoteVC.POST_URL_TEXT)!)
        let noteData: NoteData = NoteData(token: Configuration.shared.token, data: noteTextField.stringValue)
        
        let encodedData = try? JSONEncoder().encode(noteData)
        urlRequest.httpBody = encodedData
        
        AF.request(urlRequest).responseJSON { (response) in
            
            if response.error != nil {
                print("error is \(String(describing: response.error))")
                print("Unable to connect")
                return
            }
            
            guard let respData: NoteResponseData = try? JSONDecoder().decode(NoteResponseData.self, from: response.data!) else {
                return
            }
            
            if respData.success == false {
                return
            }
            
            DispatchQueue.main.async {
                (NSApplication.shared.delegate as? AppDelegate)?.statusBarController.closeNoteWindow()
            }
        }
        
    }
    
}


fileprivate struct NoteData: Codable {
    let token: String
    let data: String
}


fileprivate struct NoteResponseData: Codable {
    let success: Bool
}
