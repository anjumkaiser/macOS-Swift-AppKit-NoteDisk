//
//  SignInVC.swift
//  NoteDisk
//
//  Created by Muhammad Anjum Kaiser on 16/11/2021.
//

import Cocoa
import Alamofire

enum SignInMode {
    case SignIn
    case SignUp
}

class SignInVC: NSViewController {
    
    @IBOutlet weak var emailTextField: NSTextField!
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    @IBOutlet weak var signInButton: NSButton!
    @IBOutlet weak var cancelButton: NSButtonCell!
    
    var mode: SignInMode = .SignIn
    
    private static let SIGN_IN_TEXT = "Sign In"
    private static let SIGN_UP_TEXT = "Sign Up"
    
    private static let SIGN_IN_URL_TEXT = "http://64.227.33.185:8080/api/signIn"
    private static let SIGN_UP_URL_TEXT = "http://64.227.33.185:8080/api/signUp"
    
    override func viewWillAppear() {
        super.viewWillAppear()
        NSApp.setActivationPolicy(.regular)
        
        if mode == .SignIn {
            signInButton.title = SignInVC.SIGN_IN_TEXT
            view.window?.title = SignInVC.SIGN_IN_TEXT
        } else {
            signInButton.title = SignInVC.SIGN_UP_TEXT
            view.window?.title = SignInVC.SIGN_UP_TEXT
        }
        
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        NSApp.setActivationPolicy(.accessory)
    }
    
    @IBAction func cancelButton_Clicked(_ sender: Any) {
        self.view.window?.orderOut(self)
    }
    
    @IBAction func signInButton_Clicked(_ sender: Any) {
        
        var urlRequest: URLRequest
        
        if mode == .SignUp {
            
            urlRequest = URLRequest(url: URL(string: SignInVC.SIGN_UP_URL_TEXT)!)
            let signUpData: SignUpData  = SignUpData (
                email: emailTextField.stringValue,
                password: passwordTextField.stringValue
            )
            
            let encodedData = try? JSONEncoder().encode(signUpData)
            urlRequest.httpBody = encodedData
            
        } else if mode == .SignIn {
            
            urlRequest = URLRequest(url: URL(string: SignInVC.SIGN_IN_URL_TEXT)!)
            let signInData: SignInData  = SignInData (
                email: emailTextField.stringValue,
                password: passwordTextField.stringValue
            )
            
            let encodedData = try? JSONEncoder().encode(signInData)
            urlRequest.httpBody = encodedData
            
        } else {
            return
        }
        
        urlRequest.method = .post
        urlRequest.setValue("appleication/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("appleication/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        var token: String = ""
        
        
        AF.request(urlRequest).responseJSON { (response) in
            //print(response)
            
            if response.error != nil {
                print("error is \(String(describing: response.error))")
                print("Unable to connect")
                return
            }
            
            print("response data is \(String(describing: response.data))")
            
            if self.mode == .SignIn {
                
                guard let respData: SignInResponseData = try? JSONDecoder().decode(SignInResponseData.self, from: response.data!) else {
                    return
                }
                
                if respData.success == false {
                    return
                }
                
                token = respData.token
                print("token is \(respData.token)")
                
            } else if self.mode == .SignUp {
                
                guard let respData: SignUpResponseData = try? JSONDecoder().decode(SignUpResponseData.self, from: response.data!) else {
                    return
                }
                
                if respData.success == false {
                    return
                }
            }
            
            DispatchQueue.main.async {
                (NSApplication.shared.delegate as? AppDelegate)?.statusBarController.closeSignInWindow()
            }
            
        }
        
    }
}



fileprivate struct SignInData: Codable {
    let email: String
    let password: String
}


fileprivate struct SignInResponseData: Codable {
    let success: Bool
    let token: String
}


fileprivate struct SignUpData: Codable {
    let email: String
    let password: String
}


fileprivate struct SignUpResponseData: Codable {
    let success: Bool
}
