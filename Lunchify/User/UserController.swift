import Foundation
import UIKit
import OSLog

class UserController: UIViewController {
    let service = ApiService()
    let logger = Logger()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
        self.getUser()
    }
    
    public func getUser(){
        let request = Endpoints.fetchUser().request! //Force unwrap
        
        service.makeRequest(with: request, model: [UserDTO?].self) { users, error in
            if let error = error { print("DEBUG PRINT:", error); print("DEBUG PRINT: TREST"); return }
            
            users?.forEach({
                print($0?.name)
                print($0?.displayName)
                print($0?.email)
                print($0?.device)
                print($0?.active)
            })
        }
    }
}
