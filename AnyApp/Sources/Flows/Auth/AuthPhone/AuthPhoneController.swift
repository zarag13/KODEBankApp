import UI
import UIKit

final class AuthPhoneController: TemplateViewController<AuthPhoneView> {
    typealias ViewModel = AuthPhoneViewModel

    enum Event {
        case otp(ConfigAuthOtpModel)
    }

    var onEvent: ((Event) -> Void)?

    private var viewModel: ViewModel!

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
                self?.onEvent?(.otp(config))
            case .incorrectNumber:
                #warning("донастроить уведомление")
                SnackCenter.shared.showSnack(withProps: .init(message: Entrance.Error.invalidPhoneMessage, style: .error))
                self?.rootView.handle(.incorrectNumber)
            }
        }
    }
}
