import CoreData
import Foundation

extension NSManagedObjectModel {

    static func compatibleModelForStoreMetadata(_ metadata: [String: Any]) -> NSManagedObjectModel? {
        NSManagedObjectModel.mergedModel(from: [Bundle.main], forStoreMetadata: metadata)
    }
}
