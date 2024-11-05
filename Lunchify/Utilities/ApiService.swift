import Foundation

final class ApiService {
    static let BASE_URL: String = "http://localhost:3000/api/"
    static let shared = ApiService()
    
    func fetch<T: Codable>(endpoint: String, type: T.Type, completionHandler: @escaping (T) -> Void, errorHandler: @escaping (String) -> Void) {
        let request: URLRequest = requestBuilder(endpoint: endpoint, httpMethod: nil)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error as Any)
                errorHandler(error?.localizedDescription ?? "Error!")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("status code is not 200")
                errorHandler("Status code is not 200")
                print(response as Any)
            }
            
            if let mappedResponse = try? JSONDecoder().decode(T.self, from: data) {
                completionHandler(mappedResponse)
            }
        }
        
        task.resume()
    }
    
    func manipulate<T: Codable>(endpoint: String, httpMethod: String, params: AnyObject, type: T.Type, completionHandler: @escaping (T) -> Void, errorHandler: @escaping (String) -> Void) {
        let request: URLRequest = requestBuilder(endpoint: endpoint, httpMethod: httpMethod)
        let data = try! JSONSerialization.data(withJSONObject: params, options: [])
        
        let task = URLSession.shared.uploadTask(with: request, from: data) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error as Any)
                errorHandler(error?.localizedDescription ?? "Error!")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 201 ||  httpStatus.statusCode != 204 {
                print("status code is not 201 or 204")
                errorHandler("Status code is not 201 or 204")
                print(response as Any)
            }
            
            if let mappedResponse = try? JSONDecoder().decode(T.self, from: data) {
                completionHandler(mappedResponse)
            }
        }
        
        task.resume()
    }
    
    func requestBuilder(endpoint: String, httpMethod: String?) -> URLRequest {
        let base = "http://localhost:3000/api/"
        guard let url = URL(string: base + endpoint) else {fatalError("URL builder has failed")}
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request;
    }
}
