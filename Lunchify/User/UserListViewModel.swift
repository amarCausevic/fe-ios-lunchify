import Foundation
import OSLog
import Combine

class UserListViewModel: ObservableObject {
    let logger = Logger()
    @Published var users: [UserDTO] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
//    public func getUser(){
//        let request = Endpoints.fetchUser().request! //Force unwrap
//        
//        service.makeRequest(with: request, model: [UserDTO?].self) { users, error in
//            if let error = error { print("DEBUG PRINT:", error); print("DEBUG PRINT: TEST"); return }
//            
//            users?.forEach({
//                print($0?.name)
//                print($0?.displayName)
//                print($0?.email)
//                print($0?.device)
//                print($0?.active)
//            })
//        }
//    }
    
    func loadUsers() {
        isLoading = true
        errorMessage = nil
        let request = Endpoints.fetchUser().request!
        //Cannot assign value of type 'Result<[UserDTO]?, any Error>' to type 'Result<[UserDTO], any Error>'
        Task {
            let result: Result<[UserDTO], Error> = await ApiService.shared.request(with: request,  model: [UserDTO].self)
            
            switch result {
            case .success(let users):
                self.users = users
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
            
            self.isLoading = false
        }
    }
}
