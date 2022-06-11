import SharedInterfaces
import IdentifiedCollections
import ToolKit
import Models
import Combine
import CatalogClient

final class RemoteCatalogSource: CatalogSource {

    let permissions: CatalogDataSourcePermissions = .read
    private var client: CatalogClient?

    func set(client: CatalogClient) {
        self.client = client
    }

    func read() -> AnyPublisher<IdentifiedArrayOf<CatalogItem>, AppError> {
        guard let client = client else {
            return Fail(error: AppError.common(description: "Client is not instantiated")).eraseToAnyPublisher()
        }

        return client
            .fetch()
            .map { IdentifiedArrayOf(uniqueElements: $0) }
            .eraseToAnyPublisher()
    }
}