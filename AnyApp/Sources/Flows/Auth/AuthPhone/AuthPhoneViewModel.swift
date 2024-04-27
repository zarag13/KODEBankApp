import Services
import Combine
import UI

final class AuthPhoneViewModel {

    enum Output {
        case otp(ConfigAuthOtpModel)
        case incorrectNumber
        //case error(ErrorView.Props)
    }

    enum Input {
        case phoneEntered(String)
    }

    var onOutput: ((Output) -> Void)?

    private let authRequestManager: AuthRequestManagerAbstract

    private var cancellables = Set<AnyCancellable>()

    init(authRequestManager: AuthRequestManagerAbstract) {
        self.authRequestManager = authRequestManager
    }

#warning("донастроить кол-во кейсов с ошибками и т.д")
    func handle(_ input: Input) {
        switch input {
        case .phoneEntered(let phone):
            let clearPhone = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            if clearPhone.count == 11 {
                self.login(phone: clearPhone)
                //self.onOutput?(.error(.init(title: "123", message: "1231", image: Asset.logoM.image, buttonTitle: "dasas")))
            } else {
                self.onOutput?(.incorrectNumber)
            }
        }
    }

    private func login(phone: String) {
        authRequestManager.authLogin(phone: phone)
            .sink(
                receiveCompletion: { error in
                    guard case let .failure(error) = error else { return }
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
}
