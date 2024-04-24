import Services
import Combine

final class AuthPhoneViewModel {

    enum Output {
        case otp(ConfigModel)
        case incorrectNumber
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
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            switch input {
            case .phoneEntered(let phone):
                let clearPhone = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                if clearPhone.count == 11 {
                    self.login(phone: clearPhone)
                } else {
                    self.onOutput?(.incorrectNumber)
                }
            }
        }
    }

    private func login(phone: String) {
        authRequestManager.authLogin(phone: "")
            .sink(
                receiveCompletion: { _ in
                    // TODO: handle error
                },
                receiveValue: { [weak self] response in
                    self?.onOutput?(.otp(.init(phone: phone, code: "123456", leghtCode: 6)))
                }
            ).store(in: &cancellables)
    }
}
