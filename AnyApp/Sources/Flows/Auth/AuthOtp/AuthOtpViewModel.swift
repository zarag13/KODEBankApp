import Services
import Combine

final class AuthOtpViewModel {

    enum Input {
        case didLoad
        case otpEntered(String)
    }

    enum Output {
        case userLoggedIn
        case codeError
        case otpLenght(Int)
    }

    var onOutput: ((Output) -> Void)?

    private let authRequestManager: AuthRequestManagerAbstract
    private let appSession: AppSession

    private var cancellables = Set<AnyCancellable>()

    let configModel: ConfigAuthOtpModel

    init(
        authRequestManager: AuthRequestManagerAbstract,
        appSession: AppSession,
        configModel: ConfigAuthOtpModel
    ) {
        self.authRequestManager = authRequestManager
        self.appSession = appSession
        self.configModel = configModel
    }

    func handle(_ input: Input) {
        switch input {
        case .otpEntered(let code):
            if code == configModel.code {
                print("код верный")
                confirmOtp()
            } else {
                self.onOutput?(.codeError)
                print("код неверный")
            }
        case .didLoad:
            onOutput?(.otpLenght(configModel.leghtCode))
        }
    }

    private func confirmOtp() {
        authRequestManager.authConfirm(otpId: "", phone: "", otpCode: "")
            .sink(
                receiveCompletion: { _ in
                    // handle error
                }, receiveValue: { [weak self] response in
                    self?.appSession.handle(.updateTokens(
                        accessToken: response.guestToken,
                        refreshToken: ""
                    ))
                    self?.onOutput?(.userLoggedIn)
                }
            ).store(in: &cancellables)
    }
}
