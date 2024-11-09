import SwiftUI
import SwiftData
import OSLog

@main
struct LunchifyApp: App {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    
    var body: some Scene {
        
        WindowGroup {
            if !isLoggedIn {
                LoginView()
            } else {
                UsersView()
            }
        }
    }
}
