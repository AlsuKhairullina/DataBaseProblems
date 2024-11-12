//
//  PhotoViewModel.swift
//  CoreDataSolutions
//
//  Created by Alexander Korchak on 14.12.2023.
//

import UIKit
import CoreData

@MainActor
final class PhotoViewModel: ObservableObject {
    
    private let dataManager: CoreDataManager
    
    @Published var image: UIImage?
    
    let urlString = "https://skitterphoto.com/photos/skitterphoto-12137-default.jpg"

    init(dataManager: CoreDataManager = CoreDataManager.shared) {
        self.dataManager = dataManager
        fetchImageFromStorage()
    }

    func fetchImage() async {
        let url = URL(string: urlString)!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let downloadedImage = UIImage(data: data) {
                self.image = downloadedImage
                dataManager.saveImage(downloadedImage, title: "default")
            } else {
                print("Failed to convert data to UIImage.")
            }
        } catch {
            print("Failed to fetch image:", error)
        }
    }
    
    func fetchImageFromStorage() {
        image = dataManager.fetchImage(withTitle: "default")
    }

}
