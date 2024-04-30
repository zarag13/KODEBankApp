import UI
import UIKit
import AppIndependent

final class AuthOtpController: TemplateViewController<AuthOtpView>, NavigationBarAlwaysVisible {

    typealias ViewModel = AuthOtpViewModel

    enum Event {
        case userLoggedIn
    }

    // MARK: - Private Properties
    private var viewModel: ViewModel!
    private let loadingView = BlurLoadingView()

    // MARK: - Public Properties
    var onEvent: ((Event) -> Void)?

    // MARK: - Private Methods
    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func setup() {
        super.setup()
        setupBindings()
        viewModel.handle(.didLoad)
    }

    private func setupBindings() {
        self.rootView.onEvent = { [weak self] event in
            switch event {
            case .onOtpField(let code):
                self?.setBlurView(.loading)
                self?.viewModel.handle(.otpEntered(code))
            case .onAttemptsFailed:
                self?.createAttemptsFailedAlert()
            case .refresh:
                self?.setBlurView(.loading)
                self?.viewModel.handle(.refreshCode)
            }
        }

        viewModel.onOutput = { [weak self] output in
            switch output {
            case .userLoggedIn:
                self?.setBlurView(.none)
                self?.onEvent?(.userLoggedIn)
            case .codeError:
                self?.setBlurView(.none)
                self?.rootView.handle(.error)
            case .otpLenght(let lenght):
                self?.rootView.configuration(otpLenght: lenght)
            case .updateCode(let lenght):
                self?.setBlurView(.none)
                self?.rootView.updateConfiguration(otpLenght: lenght)
            case .noInternet(let alert):
                self?.stopErrorAnimation()
                self?.present(alert, animated: true)
            case .error(let props):
                self?.setBlurView(.none)
                self?.navigationController?.setNavigationBarHidden(true, animated: false)
                self?.stopErrorAnimation()
                self?.setAdditionState(.error(props))
            case .errorViewClosed:
                self?.navigationController?.setNavigationBarHidden(false, animated: false)
                self?.rootView.handle(.clearCode)
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

    private func setBlurView(_ state: AdditionalState) {
        switch state {
        case .none:
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            loadingView.close()
        case .loading:
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            view.embed(subview: loadingView, useSafeAreaGuide: false)
            loadingView.open()
        default: break
        }
    }
}
