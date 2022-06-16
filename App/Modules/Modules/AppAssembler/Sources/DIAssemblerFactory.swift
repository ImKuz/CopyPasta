import Swinject
import Database
import IPAddressProvider
import CatalogServer
import CatalogClient
import CatalogSource
import Logger

import RootFeature
import CatalogFeature
import AddItemFeature
import RemoteFeature

public enum DIAssemblerFactory {

    public static func make(container: Container) -> Assembler {
        let assmbler = Assembler(container: container)
        applyAssemblies(to: assmbler)
        return assmbler
    }

    private static func applyAssemblies(to assembler: Assembler) {
        assembler.apply(assemblies: [

            // MARK: - Services

            ServicesAssembly(),
            LoggerAssembly(),
            DatabaseServiceAssembly(),
            IPAddressProviderAssembly(),
            CatalogServerAssembly(),
            CatalogClientAssembly(),
            CatalogSourceAssembly(),

            // MARK: - Features

            RootFeatureAssembly(),
            CatalogFeatureAssembly(),
            AddItemFeatureAssembly(),
            RemoteFeatureAssembly(),
        ])
    }
}
