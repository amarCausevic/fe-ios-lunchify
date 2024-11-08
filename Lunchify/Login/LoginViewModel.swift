import Foundation
import SwiftUI

struct LoginViewModel{
    @State private var username = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var errorMessage: String?
    
    func login() {
        if username == "user" && password == "password" {
            isLoggedIn = true
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            return;
        }
        
        errorMessage = "Invalid credentials."
    }
}
