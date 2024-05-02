import UI
import UIKit
import Services
import Combine

final class AuthPhoneViewModel: NetworkErrorHandler {
    enum Output {
        case otp(ConfigAuthOtpModel)
        case incorrectNumber
        case error(ErrorView.Props)
        case noInternet(UIAlertController)
        case closeErrorView
    }
    enum Input {
        case phoneEntered(String)
    }

    // MARK: - Private Properties
    private let authRequestManager: AuthRequestManagerAbstract
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Public Properties
    public var onOutput: ((Output) -> Void)?

    // MARK: - Private Methods
    init(authRequestManager: AuthRequestManagerAbstract) {
        self.authRequestManager = authRequestManager
    }

    private func login(phone: String) {
        authRequestManager.authLogin(phone: phone)
            .sink(
                receiveCompletion: { [weak self] error in
                    guard case let .failure(error) = error else { return }
                    guard let errorProps = self?.errorHandle(
                        error,
                        onTap: {
                        if error.appError.kind == .timeout {
                            self?.checkInternet(returnAlert: { alert in
                                self?.onOutput?(.noInternet(alert))
                            }, returnIsOn: {
                                self?.login(phone: phone)
                            })
                        } else {
                            self?.login(phone: phone)
                        }
                    }, closeTap: {
                        self?.onOutput?(.closeErrorView)
                    }) else { return }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self?.onOutput?(.error(errorProps))
                    }
                },
                receiveValue: { [weak self] response in
                    let otpModel = ConfigAuthOtpModel(
                        phone: phone,
                        code: response.otpCode,
                        leghtCode: response.otpLen,
                        codeId: response.otpId)
                    self?.onOutput?(.otp(otpModel))
                }
            ).store(in: &cancellables)
    }

    // MARK: - Public Methods
    func handle(_ input: Input) {
        switch input {
        case .phoneEntered(let phone):
            let clearPhone = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            print(clearPhone)
            if clearPhone.count == 11 {
                self.login(phone: clearPhone)
            } else {
                self.onOutput?(.incorrectNumber)
            }
        }
    }
}
