// UnsplashEndpoint.swift
import Foundation

enum UnsplashEndpoint {
    case randomPhotos(count: Int)
    case searchPhotos(query: String, page: Int)
    
    // 1. Base components usually constant across the app
    var scheme: String { "https" }
    var host: String { APIConfig.baseURL }
    
    // 2. Define paths for each case
    var path: String {
        switch self {
        case .randomPhotos:
            return "/photos/random"
        case .searchPhotos:
            return "/search/photos"
        }
    }
    
    // 3. Define query items (parameters) safely
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem(name: "client_id", value: APIConfig.apiKey)]
        
        switch self {
        case .randomPhotos(let count):
            items.append(URLQueryItem(name: "count", value: String(count)))
            
        case .searchPhotos(let query, let page):
            items.append(URLQueryItem(name: "query", value: query))
            items.append(URLQueryItem(name: "page", value: String(page)))
        }
        
        return items
    }
    
    // 4. Computed property to build the final URL
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}
