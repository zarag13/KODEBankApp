//
//  ProfileFlowCoordinator.swift
//  AnyApp
//
//  Created by Kirill on 22.04.2024.
//

import Core
import Services
import Swinject
import AppIndependent
import SwinjectAutoregistration

final class ProfileFlowCoordinator: Coordinator {

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

    func profileController() -> UIViewController? {
        let controller = resolver ~> ProfileController.self
        innerRouter.setRootModule(controller)

        controller.openSettingsController = { [weak self] event in
            switch event {
            case .themeApp:
                self?.themeAppController()
            case .aboutApp:
                self?.aboutAppController()
            }
        }
        return innerRouter.rootController
    }

    private func themeAppController() {
        let controller = resolver ~> ThemeAppController.self
        controller.hidesBottomBarWhenPushed = true
        innerRouter.push(controller)
    }

    private func aboutAppController() {
        let controller = resolver ~> AboutAppController.self
        controller.hidesBottomBarWhenPushed = true
        innerRouter.push(controller)
    }
}
