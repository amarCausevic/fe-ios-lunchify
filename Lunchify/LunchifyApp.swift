import SwiftUI
import SwiftData
import OSLog

@main
struct LunchifyApp: App {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    let logger = Logger()
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                UsersView()
            } else {
                LoginView()
            }
        }
    }
}
