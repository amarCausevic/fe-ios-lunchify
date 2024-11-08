import Foundation
import OSLog
import Combine

class UserListViewModel: ObservableObject {
    let logger = Logger()
    @Published var users: [UserDTO] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
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
