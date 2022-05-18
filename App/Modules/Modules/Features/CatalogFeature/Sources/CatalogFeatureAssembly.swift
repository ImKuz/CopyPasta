import ComposableArchitecture
import Database
import Swinject
import SharedEnv
import ToolKit
import Models
import SharedInterfaces
import SwiftUI
import UIKit

public struct CatalogFeatureAssembly: Assembly {

    private let container: Container

    public init(container: Container) {
        self.container = container
    }

    // MARK: - Public methods

    public func assemble(container: Container) {

        // MARK: - Local data source
        container.register(CatalogFeatureInterface.self, name: "local") { resolver in
            let source = CatalogSourceMock()
            let navigationController = UINavigationController()
            let router = container.resolve(Router.self, argument: navigationController)!

            let environment = CatalogEnvImpl(
                container: container,
                catalogSource: source,
                pastboard: UIPasteboard.general,
                router: router
            )

            let store = Store(
                initialState: .initial(title: "Local"),
                reducer: CatalogReducerFactory().make(),
                environment: SystemEnv.make(environment: environment)
            )

            let viewController = CatalogViewController(store: store)
            navigationController.pushViewController(viewController, animated: false)

            let view = AnyView(
                UINavigationControllerHolder(navigationController: navigationController)
            )

            return CatalogFeatureInterface(view: view)
        }
    }
}
