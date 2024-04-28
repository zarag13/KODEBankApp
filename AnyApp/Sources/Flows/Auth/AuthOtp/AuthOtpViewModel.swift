import Services
import Combine

final class AuthOtpViewModel {

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
    }

    var onOutput: ((Output) -> Void)?

    private let authRequestManager: AuthRequestManagerAbstract
    private let appSession: AppSession

    private var cancellables = Set<AnyCancellable>()

    var configModel: ConfigAuthOtpModel

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
        case .refreshCode:
            refreshCode(phone: configModel.phone)
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

    private func refreshCode(phone: String) {
        authRequestManager.authLogin(phone: phone)
            .sink(
                receiveCompletion: { error in
                    guard case let .failure(error) = error else { return }
                    switch error.appError.kind {
                    case .network:
                        print("network")
                    case .timeout:
                        print("нет интернета ошибка тут-")
                    case .serverSendWrongData:
                        print("serverSendWrongData")
                    case .server(_):
                        print("server")
                    case .internal:
                        print("internal")
                    }
                    print(error.appError.localizedDescription)
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
}
