//
//  CoreDataManager.swift
//  CoreDataSolutions
//
//  Created by Alexander Korchak on 14.12.2023.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {

    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PhotosModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        ValueTransformer.setValueTransformer(UIImageTransformer(), forName: NSValueTransformerName("UIImageTransformer"))
    }
    
    func saveImage(_ image: UIImage, title: String) {
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if let existingPhoto = results.first {
                existingPhoto.content = image
                print("Image updated successfully with title: \(title)")
            } else {
                let newPhoto = Photo(context: context)
                newPhoto.content = image
                newPhoto.title = title
                print("New image saved successfully with title: \(title)")
            }
            try context.save()
        } catch {
            print("Failed to save or update image: \(error)")
        }
    }
    
    func fetchImage(withTitle title: String) -> UIImage? {
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.first?.content
        } catch {
            print("Failed to fetch image: \(error)")
            return nil
        }
    }
}


