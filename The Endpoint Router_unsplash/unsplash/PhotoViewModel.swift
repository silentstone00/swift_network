// PhotoViewModel.swift
import Foundation
internal import Combine

@MainActor
class PhotoViewModel: ObservableObject {
    @Published var photos: [UnsplashPhoto] = []
    @Published var errorMessage: String?
    
    func loadRandomPhotos() async {
        do {
            // Using the Endpoint Enum here makes the call very readable
            let fetchedPhotos = try await NetworkManager.shared.fetch(
                endpoint: .randomPhotos(count: 10),
                type: [UnsplashPhoto].self
            )
            self.photos = fetchedPhotos
        } catch {
            self.errorMessage = "Failed to load photos: \(error.localizedDescription)"
        }
    }
}
