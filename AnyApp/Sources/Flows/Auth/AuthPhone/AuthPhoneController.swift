import UI
import UIKit

final class AuthPhoneController: TemplateViewController<AuthPhoneView> {
    typealias ViewModel = AuthPhoneViewModel

    enum Event {
        case otp
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
        navigationController?.navigationBar.isHidden = true
    }

    private func setupBindings() {
        rootView.onAuth = { [weak self] phone in
            self?.viewModel.handle(.phoneEntered(phone))
        }

        viewModel.onOutput = { [weak self] output in
            switch output {
            case .otp:
                self?.rootView.onEvent?(.corect)
                self?.onEvent?(.otp)
            case .incorrectNumber:
                #warning("донастроить уведомление")
                SnackCenter.shared.showSnack(withProps: .init(message: "123131", style: .error))
                self?.rootView.onEvent?(.incorrect)
            }
        }
    }
}
