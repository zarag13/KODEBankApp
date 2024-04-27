import UI
import UIKit

final class AuthOtpController: TemplateViewController<AuthOtpView> {

    typealias ViewModel = AuthOtpViewModel

    enum Event {
        case userLoggedIn
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
        viewModel.handle(.didLoad)
    }
    
    private func configureNavigationItem() {
        rootView.navigationBar.popController(navigation: self.navigationController)
    }

    private func setupBindings() {
        rootView.onOtpFilled = { [weak self] code in
            self?.viewModel.handle(.otpEntered(code))
        }

        viewModel.onOutput = { [weak self] output in
            switch output {
            case .userLoggedIn:
                self?.onEvent?(.userLoggedIn)
            case .codeError:
                self?.rootView.handle(.error)
            case .otpLenght(let lenght):
                self?.rootView.configuration(otpLenght: lenght)
            }
        }
    }
}
