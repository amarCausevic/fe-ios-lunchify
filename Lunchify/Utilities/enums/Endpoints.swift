import Foundation

enum Endpoints {
    case fetchUser(url: String = "/api/user")
    case updateUser(url: String = "/api/user", update: UserDTO)
    
    var request: URLRequest? {
        guard let url = self.url else {return nil}
        var request = URLRequest(url: url)
        
        request.httpMethod = self.httpMethod
        request.httpBody = self.httpBody
        request.addValues(for: self)

        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        components.port = Constants.port
        components.path = self.path
        return components.url
    }
    
    private var path: String {
           switch self {
           case .fetchUser(let url): return url
           case .updateUser(let url, _): return url
           }
       }
    
    private var httpMethod: String {
        switch self {
        case .fetchUser:
            return HTTP.Method.get.rawValue
        case .updateUser:
            return HTTP.Method.post.rawValue
        }
    }
    
    private var httpBody: Data? {
        switch self {
        case .fetchUser:
            return nil
        case .updateUser(_, let update):
            let jsonPost = try? JSONEncoder().encode(update)
            return jsonPost
        }
    }
}

extension URLRequest {
    
    mutating func addValues(for endpoints: Endpoints) {
        switch endpoints {
        case .fetchUser:
            break
        case .updateUser:
            self.setValue(
                HTTP.Headers.Value.applicationJson.rawValue,
                forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue
            )
        }
    }
}
