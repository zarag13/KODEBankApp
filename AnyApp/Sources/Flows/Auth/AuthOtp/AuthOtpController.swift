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
        self.rootView.onEvent = { [weak self] event in
            switch event {
            case .onOtpField(let code):
                self?.viewModel.handle(.otpEntered(code))
            case .onAttemptsFailed:
                self?.createAttemptsFailedAlert()
            case .refresh:
                self?.viewModel.handle(.refreshCode)
            }
        }

        viewModel.onOutput = { [weak self] output in
            switch output {
            case .userLoggedIn:
                self?.onEvent?(.userLoggedIn)
            case .codeError:
                self?.rootView.handle(.error)
            case .otpLenght(let lenght):
                self?.rootView.configuration(otpLenght: lenght)
            case .updateCode(let lenght):
                self?.rootView.updateConfiguration(otpLenght: lenght)
            }
        }
    }

    private func createAttemptsFailedAlert() {
        let alert = UIAlertController(
            title: "Вы ввели неверно код 5 раз",
            message: "Данная сессия авторизации будет сброшена!",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "Выход", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
