import Services
import UIKit
import Combine
import UI

final class AuthOtpViewModel: NetworkErrorHandler {

    enum Input {
        case didLoad
        case otpEntered(String)
        case refreshCode
    }

    enum Output {
        case userLoggedIn
        case codeError
        case otpLenght(Int)
        case updateCode(Int)
        case noInternet(UIAlertController)
        case error(ErrorView.Props)
        case errorViewClosed
    }

    // MARK: - Private Properties
    private let authRequestManager: AuthRequestManagerAbstract
    private let appSession: AppSession
    private var cancellables = Set<AnyCancellable>()
    private var configModel: ConfigAuthOtpModel

    // MARK: - Public Properties
    var onOutput: ((Output) -> Void)?

    // MARK: - Private Methods
    init(
        authRequestManager: AuthRequestManagerAbstract,
        appSession: AppSession,
        configModel: ConfigAuthOtpModel
    ) {
        self.authRequestManager = authRequestManager
        self.appSession = appSession
        self.configModel = configModel
    }

    private func confirmOtp(otpCode: String) {
        authRequestManager.authConfirm(otpId: configModel.codeId, phone: configModel.phone, otpCode: otpCode)
            .sink(
                receiveCompletion: { [weak self] error in
                    guard case let .failure(error) = error else { return }
                    guard let errorProps = self?.errorHandle(error, onTap: {
                        if error.appError.kind == .timeout {
                            self?.checkInternet(returnAlert: { alert in
                                self?.onOutput?(.noInternet(alert))
                            }, returnIsOn: {
                                self?.confirmOtp(otpCode: otpCode)
                            })
                        } else {
                            self?.confirmOtp(otpCode: otpCode)
                        }
                    }, closeTap: {
                        self?.onOutput?(.errorViewClosed)
                    }) else { return }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self?.onOutput?(.error(errorProps))
                    }
                }, receiveValue: { [weak self] response in
                    self?.appSession.handle(.updateTokens(
                        accessToken: response.guestToken,
                        refreshToken: ""
                    ))
                    self?.onOutput?(.userLoggedIn)
                }
            ).store(in: &cancellables)
    }

    private func refreshCode(phone: String) {
        authRequestManager.authLogin(phone: phone)
            .sink(
                receiveCompletion: { [weak self] error in
                    guard case let .failure(error) = error else { return }
                    guard let errorProps = self?.errorHandle(error, onTap: {
                        if error.appError.kind == .timeout {
                            self?.checkInternet(returnAlert: { alert in
                                self?.onOutput?(.noInternet(alert))
                            }, returnIsOn: {
                                self?.refreshCode(phone: phone)
                            })
                        } else {
                            self?.refreshCode(phone: phone)
                        }
                    }, closeTap: {
                        self?.onOutput?(.errorViewClosed)
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
                    self?.configModel = otpModel
                        self?.onOutput?(.updateCode(otpModel.leghtCode))
                    print("download new code")
                }
            ).store(in: &cancellables)
    }

    // MARK: - Public Methods
    func handle(_ input: Input) {
        switch input {
        case .otpEntered(let code):
            if code == configModel.code {
                confirmOtp(otpCode: code)
            } else {
                self.onOutput?(.codeError)
            }
        case .didLoad:
            onOutput?(.otpLenght(configModel.leghtCode))
        case .refreshCode:
            refreshCode(phone: configModel.phone)
        }
    }
}
