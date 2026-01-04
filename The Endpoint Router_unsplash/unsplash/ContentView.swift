// ContentView.swift
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PhotoViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.photos) { photo in
                HStack {
                    // Simple AsyncImage to load the URL
                    AsyncImage(url: URL(string: photo.urls.small)) { image in
                        image.resizable()
                             .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Color.gray.opacity(0.3)
                    }
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
                    
                    Text(photo.description ?? "No description")
                        .font(.caption)
                        .lineLimit(2)
                }
            }
            .navigationTitle("Unsplash API")
            .task {
                await viewModel.loadRandomPhotos()
            }
        }
    }
}
