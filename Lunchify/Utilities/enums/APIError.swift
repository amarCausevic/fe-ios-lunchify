enum APIError: Error {
    case urlSessionError(String)
    case serverError(String = "Ivalid API Key")
    case invalidResponse(String = "Ivalid Response")
    case decodingError(String = "Error while executing decoding of response")
    case noIssuesFound(String = "No issues found result is positive")
}
