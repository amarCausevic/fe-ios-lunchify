import Foundation
import OSLog

protocol Service {
    func request<T: Decodable>(with request: URLRequest, model: T.Type) async -> Result<T, Error>
}

final class ApiService: Service {
    let logger = Logger()
    static let shared = ApiService()

    @available(*, deprecated)
    func makeRequest<T: Codable>(with request: URLRequest,
                                 model: T.Type,
                                 completion: @escaping (T?, APIError?) -> Void) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, .urlSessionError(error.localizedDescription))
                self.logger.error("Invalid request made please check the response \(response)")
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode > 299 {
                self.logger.error("status code is not 201 or 204 \(response)")
                return
            }
            
            guard let data = data else {
                completion(nil, .invalidResponse())
                self.logger.error("ivalid server response \(response)")
                return
            }
            
            do{
                let result = try? JSONDecoder().decode(T.self, from: data)
                completion(result, nil)
            }catch let error{
                self.logger.error("\(error)")
                completion(nil, .decodingError())
                return
            }
        }.resume()
    }
    
    func request<T: Decodable>(with request: URLRequest, model: T.Type) async -> Result<T, Error>{
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return .failure(APIError.invalidResponse())
            }
            
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedResponse)
        } catch {
            return .failure(error)
        }
    }
}
