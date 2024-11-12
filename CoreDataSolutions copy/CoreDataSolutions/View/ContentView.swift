//
//  ContentView.swift
//  CoreDataSolutions
//
//  Created by Alexander Korchak on 14.12.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: PhotoViewModel = .init()

    var body: some View {
        VStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            Button("Download image") {
                Task {
                    await viewModel.fetchImage()
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ContentView()
}
