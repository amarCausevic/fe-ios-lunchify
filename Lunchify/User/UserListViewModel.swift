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
        
        Task {
            try await Task.sleep(nanoseconds: 2_000_000_000)

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
