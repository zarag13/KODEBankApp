import UI
import UIKit

final class AuthPhoneController: TemplateViewController<AuthPhoneView> {
    typealias ViewModel = AuthPhoneViewModel

    enum Event {
        case otp(ConfigAuthOtpModel)
    }

    // MARK: - Private Properties
    private var viewModel: ViewModel!

    // MARK: - Public Properties
    public var onEvent: ((Event) -> Void)?

    // MARK: - Private Methods
    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func setup() {
        super.setup()
        setupBindings()
        configureNavigationItem()
    }

    private func configureNavigationItem() {
        navigationController?.navigationBar.isHidden = true
    }

    private func setupBindings() {
        rootView.onEvent = { [weak self] phone in
            switch phone {
            case .onLogin(let phone):
                self?.viewModel.handle(.phoneEntered(phone))
            }
        }

        viewModel.onOutput = { [weak self] output in
            switch output {
            case .otp(let config):
                self?.rootView.handle(.correct)
                self?.onEvent?(.otp(config))
            case .incorrectNumber:
                #warning("донастроить уведомление")
                SnackCenter.shared.showSnack(withProps: .init(message: Entrance.Error.invalidPhoneMessage, style: .error))
                self?.rootView.handle(.incorrectNumber)
            case .error(let props): break
            }
        }
    }
}

//self?.setAdditionState(.error(props))

//public struct ErrorUIHandler {
//    static func handle(_ error: ErrorWithContext, onTap: @escaping VoidHandler) -> ErrorView.Props {
//        switch error.appError.kind {
//        case .network:
//            ErrorView.Props(
//                title: <#T##String#>,
//                message: <#T##String#>,
//                image: <#T##UIImage#>,
//                buttonTitle: <#T##String#>,
//                onTap: onTap
//            )
//        default:
//            break
//        }
//    }
//}
