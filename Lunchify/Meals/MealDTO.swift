import Foundation

struct MealDTO: Identifiable, Codable {
    let id: String?
    let name: String?
    let displayName: String?
    let ingredients: String?
    let cautionIngredients: String?
    let comments: String?
    let timestampCreated: String?
    let timestampPrepareOn: String?
}

struct MealResponse: Decodable {
    let request: [MealDTO]
}
