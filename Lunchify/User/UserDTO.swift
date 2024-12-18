import Foundation

struct UserDTO: Codable {
    let id: String
    let name: String
    let displayName: String
    let email: String
    let device: String
    let active: Bool
}

struct UserResponse: Decodable {
    let request: [UserDTO]
}
