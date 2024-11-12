//
//  CoreDataManager.swift
//  CoreDataSolutions
//
//  Created by Alexander Korchak on 14.12.2023.
//

import Foundation
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()
    // TODO: add neccessary code

    private init() {
        ValueTransformer.setValueTransformer(UIImageTransformer(), forName: NSValueTransformerName("UIImageTransformer"))
        // TODO: add neccessary code
    }
}
