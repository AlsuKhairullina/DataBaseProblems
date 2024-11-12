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
    @Published var image: UIImage?
    let urlString = "https://skitterphoto.com/photos/skitterphoto-12137-default.jpg"

    // TODO: add neccessary code

    init() {

    }

    func fetchImage() async {
        let url = URL(string: urlString)!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            // TODO: add neccessary code

        } catch  {
            print(error)
        }
    }
}
