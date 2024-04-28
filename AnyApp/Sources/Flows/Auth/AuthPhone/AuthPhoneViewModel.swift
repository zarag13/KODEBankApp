import Services
import UIKit
import Foundation
import Combine
import UI
import Core

final class AuthPhoneViewModel: ErrorUIHandler {
    enum Output {
        case otp(ConfigAuthOtpModel)
        case incorrectNumber
        case error(ErrorView.Props)
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
                    guard let errorProps = self?.errorHandle(error, onTap: {
                        if error.appError.kind == .timeout {
                            self?.checkInternet()
                        }
                        self?.login(phone: phone)
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
            if clearPhone.count == 11 {
                self.login(phone: clearPhone)
            } else {
                self.onOutput?(.incorrectNumber)
            }
        }
    }
}

import Network
// swiftlint:disable:next final_class
class ErrorUIHandler {
    
    private var monitor: NWPathMonitor?

    func errorHandle(_ error: ErrorWithContext, onTap: @escaping (() -> Void)) -> ErrorView.Props {
        switch error.appError.kind {
        case .timeout:
            return .init(title: Common.attention, message: Common.Error.noInternet, image: Asset.BigIlustration.notWifi.image, buttonTitle: Common.repeat, onTap: onTap)
        case .serverSendWrongData:
            return .init(title: Common.attention, message: Common.Error.serverNotFound, image: Asset.BigIlustration.notData.image, buttonTitle: Common.repeat, onTap: onTap)
        default:
            return .init(title: Common.attention, message: Common.Error.engineringWorks, image: Asset.BigIlustration.notData.image, buttonTitle: Common.repeat, onTap: onTap)
        }
    }

    func checkInternet() {
        monitor = NWPathMonitor()
        self.monitor?.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
            } else {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                      print("Can open real Divace")
                    }
                }
            }
            self.monitor?.cancel()
            self.monitor = nil
            print("123")
        }
        self.monitor?.start(queue: .main)
    }
}
