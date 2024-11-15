import Foundation
import OSLog
import Combine

class OrderListViewModel: ObservableObject {
    let logger = Logger()
    @Published var orderHistory: [OrderHistroyDTO] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    func getUserOrderHistoryList() {
        isLoading = true
        errorMessage = nil
        let request = Endpoints.fetchOrders().request!
        
        Task {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            let result: Result<[OrderHistroyDTO], Error> = await ApiService.shared.request(with: request,  model: [OrderHistroyDTO].self)
            switch result {
            case .success(let orderHistory):
                self.orderHistory = orderHistory
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                print("A string interpolation \(result)")
            }
            
            self.isLoading = false
        }
    }

}
