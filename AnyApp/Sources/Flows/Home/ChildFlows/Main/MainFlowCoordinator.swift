import Core
import Services
import Swinject
import AppIndependent
import SwinjectAutoregistration

final class MainFlowCoordinator: Coordinator {

    // MARK: - Private Properties

    private let appSession: AppSession = resolver ~> AppSession.self
    private let innerRouter: RouterAbstract

    // MARK: - MainFlowCoordinator

    public init(rootRouter: RouterAbstract, innerRouter: RouterAbstract) {
        self.innerRouter = innerRouter
        super.init(router: rootRouter)
    }
    required init(router: any RouterAbstract) {
        fatalError("init(router:) has not been implemented")
    }

    func mainController() -> UIViewController? {
        let controller = resolver ~> MainController.self
        innerRouter.setRootModule(controller)
        controller.openDetailController = { [weak self] event in
            switch event {
            case .detailCard(let model):
                self?.detailCardController(model)
            case .detailAccount(let model):
                self?.detailAccountController(model)
            }
        }
        return innerRouter.rootController
    }

    private func detailCardController(_ id: DetailCardModel) {
        let controller = resolver ~> (DetailCardController.self, id)
        controller.hidesBottomBarWhenPushed = true
        innerRouter.push(controller)
    }

    private func detailAccountController(_ model: ConfigurationDetailAccountModel) {
        let controller = resolver ~> (DetailAccountController.self, model)
        controller.hidesBottomBarWhenPushed = true
        innerRouter.push(controller)
    }
}
