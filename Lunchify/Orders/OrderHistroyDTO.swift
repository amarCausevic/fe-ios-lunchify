import Foundation

struct OrderHistroyDTO: Identifiable, Codable {
    let id: String
    let userName: String
    let userId: String
    let meals: [MealDTO]?
    let status: String
    let timestampCreated: String
    let userComment: String
}

struct OrderHistroyResponse: Decodable {
    let request: [OrderHistroyDTO]
}
