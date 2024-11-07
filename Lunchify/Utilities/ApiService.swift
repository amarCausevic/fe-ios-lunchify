import Foundation
import OSLog

protocol Service {
    func makeRequest<T: Codable>(with request: URLRequest,
                                 model: T.Type,
                                 completion: @escaping (T?, APIError?) -> Void)
}

final class ApiService: Service {
    let logger = Logger()
    
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
}
