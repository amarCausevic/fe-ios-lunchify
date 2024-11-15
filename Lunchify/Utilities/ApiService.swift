import Foundation
import OSLog

protocol Service {
    func request<T: Decodable>(with request: URLRequest, model: T.Type) async -> Result<T, Error>
}

final class ApiService: Service {
    let logger = Logger()
    static let shared = ApiService()
    
    func request<T: Decodable>(with request: URLRequest, model: T.Type) async -> Result<T, Error>{
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return .failure(APIError.invalidResponse())
            }
            
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            print("This is result: \(decodedResponse)")
            return .success(decodedResponse)
        } catch {
            return .failure(error)
        }
    }
}
