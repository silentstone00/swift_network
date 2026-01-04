// UnsplashPhoto.swift
import Foundation

struct UnsplashPhoto: Identifiable, Codable {
    let id: String
    let slug: String?
    let description: String?
    let urls: PhotoURLs
    
    // Nested struct for URL variations
    struct PhotoURLs: Codable {
        let raw: String
        let full: String
        let regular: String
        let small: String
        let thumb: String
    }
}
