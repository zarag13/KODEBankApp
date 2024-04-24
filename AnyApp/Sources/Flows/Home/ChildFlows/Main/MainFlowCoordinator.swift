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
        controller.navigationController?.navigationBar.isHidden = true
        controller.openDetailController = { [weak self] event in
            switch event {
            case .detailCard:
                self?.detailCardController()
            case .detailAccount:
                self?.detailAccountController()
            }
        }
        return innerRouter.rootController
    }
    
    private func detailCardController() {
        let controller = resolver ~> DetailCardController.self
        controller.hidesBottomBarWhenPushed = true
        innerRouter.push(controller)
    }

    private func detailAccountController() {
        let controller = resolver ~> DetailAccountController.self
        controller.hidesBottomBarWhenPushed = true
        innerRouter.push(controller)
    }
}
