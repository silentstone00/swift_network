// NetworkManager.swift
import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    // Generic function to fetch data
    func fetch<T: Decodable>(endpoint: UnsplashEndpoint, type: T.Type) async throws -> T {
        
        // 1. Use the computed URL property from our Enum
        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }
        
        // Debugging: Print URL to see it being built correctly
        print("Fetching from: \(url.absoluteString)")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase // Handles things like "client_id"
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Decoding error: \(error)")
            throw NetworkError.decodingError
        }
    }
}
