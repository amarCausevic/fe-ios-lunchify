import Foundation

struct MealHistoryDTO: Codable {
    let id: String
    let name: String
    let timestampCreated: String
    let timestampPrepareOn: String
}

struct MealHistoryResponse: Decodable {
    let request: [MealHistoryDTO]
}
