import UIKit
import CoreData

@objc(Photo)
class Photo: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var content: UIImage?
    @NSManaged public var title: String?

}

extension Photo : Identifiable {

}

