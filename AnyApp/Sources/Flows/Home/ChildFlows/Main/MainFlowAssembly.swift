import UI
import Core
import Swinject
import Services
import AppIndependent
import SwinjectAutoregistration

final class MainFlowAssembly: Assembly, Identifiable {
    var id: String { String(describing: type(of: self)) }

    func assemble(container: Container) {
        container.register(BaseNavigationController.self, name: RouterName.main) { _ in
            BaseNavigationController(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        }
        .inObjectScope(.weak)

        container.register(Router.self, name: RouterName.main) { resolver in
            let navigationController = resolver ~> (BaseNavigationController.self, name: RouterName.main)
            return Router(rootController: navigationController)
        }
        .inObjectScope(.weak)

        container.register(MainFlowCoordinator.self) { resolver, router in
            let innerRouter = resolver ~> (Router.self, name: RouterName.main)
            return MainFlowCoordinator(rootRouter: router, innerRouter: innerRouter)
        }

        container.register(MainController.self) { resolver in
            let viewModel = MainViewModel(authRequestManager: (resolver ~> NetworkFactory.self).makeCoreRequestManager())
            return MainController(viewModel: viewModel)
        }

        container.register(DetailCardController.self) { resolver, model in
            let viewModel = DetailCardViewModel(cardId: model, coreRequestManager: (resolver ~> NetworkFactory.self).makeCoreRequestManager())
            return DetailCardController(viewModel: viewModel)
        }

        container.register(DetailAccountController.self) { resolver, model in
            let viewModel = DetailAccountViewModel(configurationModel: model, coreRequestManager: (resolver ~> NetworkFactory.self).makeCoreRequestManager())
            return DetailAccountController(viewModel: viewModel)
        }
    }

    func loaded(resolver: Resolver) {
        Logger().debug(id, "is loaded")
    }
}
