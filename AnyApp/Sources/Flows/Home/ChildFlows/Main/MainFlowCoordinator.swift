import Core
import Services
import Swinject
import AppIndependent
import SwinjectAutoregistration

final class MainFlowCoordinator: Coordinator {

    // MARK: - Private Properties

    private let appSession: AppSession = resolver ~> AppSession.self

    // MARK: - MainFlowCoordinator

    public convenience init(rootRouter: RouterAbstract) {
        self.init(router: rootRouter)
    }

    func mainController() -> UIViewController? {
        let controller = resolver ~> MainController.self
        router.setRootModule(controller)
        return router.rootController
    }
}
