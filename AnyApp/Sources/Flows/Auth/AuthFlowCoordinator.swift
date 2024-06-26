import Core
import Services
import Swinject
import AppIndependent
import SwinjectAutoregistration

final class AuthFlowCoordinator: Coordinator {

    enum Event {
        case userLoggedIn
    }

    var onEvent: ((Event) -> Void)?

    // MARK: - Private Properties

    private let appSession: AppSession = resolver ~> AppSession.self

    // MARK: - AuthFlowCoordinator

    required init(router: RouterAbstract) {
        super.init(router: router)
    }

    override func start() {
        showPhoneAuth()
    }

    private func showPhoneAuth() {
        let controller = resolver ~> AuthPhoneController.self

        controller.onEvent = { [weak self] event in
            switch event {
            case .otp(let config):
                self?.showOtp(config: config)
            }
        }
        router.setRootModule(controller)
    }

    private func showOtp(config: ConfigAuthOtpModel) {
        let controller = resolver ~> (AuthOtpController.self, config)

        controller.onEvent = { [weak self] event in
            switch event {
            case .userLoggedIn:
                self?.onEvent?(.userLoggedIn)
            }
        }
        router.push(controller)
    }
}
