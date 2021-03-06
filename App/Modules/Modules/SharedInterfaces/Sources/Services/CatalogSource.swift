import Combine
import IdentifiedCollections
import Models
import ToolKit

public protocol CatalogSource: AnyObject {

    var permissions: CatalogDataSourcePermissions { get }

    func subscribe() -> AnyPublisher<IdentifiedArrayOf<CatalogItem>, AppError>
    func delete(_ item: CatalogItem) -> AnyPublisher<Void, AppError>
    func move(from: Int, to: Int) -> AnyPublisher<Void, AppError>
    func add(item: CatalogItem) -> AnyPublisher<Void, AppError>

    func setIsFavorite(item: CatalogItem, isFavorite: Bool) -> AnyPublisher<Void, AppError>
}

public extension CatalogSource {

    private var message: String { "Operation is not permitted" }

    func subscribe() -> AnyPublisher<IdentifiedArrayOf<CatalogItem>, AppError> {
        guard permissions.contains(.read) else {
            return Fail(error: AppError.businessLogic(message)).eraseToAnyPublisher()
        }

        assertionFailure("method \(#function) should be implemented in \(self) accoding to its permissions")
        return Empty().eraseToAnyPublisher()
    }

    func delete(_ item: CatalogItem) -> AnyPublisher<Void, AppError> {
        guard permissions.contains(.modify) else {
            return Fail(error: AppError.businessLogic(message)).eraseToAnyPublisher()
        }

        assertionFailure("method \(#function) should be implemented in \(self) accoding to its permissions")
        return Empty().eraseToAnyPublisher()
    }

    func move(from: Int, to: Int) -> AnyPublisher<Void, AppError> {
        guard permissions.contains(.modify) else {
            return Fail(error: AppError.businessLogic(message)).eraseToAnyPublisher()
        }

        assertionFailure("method \(#function) should be implemented in \(self) accoding to its permissions")
        return Empty().eraseToAnyPublisher()
    }

    func add(item: CatalogItem) -> AnyPublisher<Void, AppError> {
        guard permissions.contains(.add) else {
            return Fail(error: AppError.businessLogic(message)).eraseToAnyPublisher()
        }

        assertionFailure("method \(#function) should be implemented in \(self) accoding to its permissions")
        return Empty().eraseToAnyPublisher()
    }
}
