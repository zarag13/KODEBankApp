import UI
import UIKit
import AppIndependent

final class AuthPhoneController: TemplateViewController<AuthPhoneView>, NavigationBarAlwaysHidden {
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
                self?.removeAdditionalState()
                self?.rootView.handle(.correct)
                self?.onEvent?(.otp(config))
            case .incorrectNumber:
                self?.removeAdditionalState()
                SnackCenter.shared.showSnack(withProps: .init(message: Entrance.Error.invalidPhoneMessage, style: .error, onTap: { [weak self] in
                    self?.rootView.handle(.correct)
                }))
                self?.rootView.handle(.incorrectNumber)
                self?.rootView.handle(.openKeyboard)
            case .error(let props):
                self?.stopErrorAnimation()
                self?.rootView.handle(.correct)
                self?.setAdditionState(.error(props))
            case .noInternet(let alert):
                self?.stopErrorAnimation()
                self?.present(alert, animated: true)
            case .closeErrorView:
                self?.rootView.handle(.openKeyboard)
            }
        }
    }
}
