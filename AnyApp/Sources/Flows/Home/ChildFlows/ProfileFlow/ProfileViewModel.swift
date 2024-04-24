import Services
import Combine
import UIKit

final class ProfileViewModel {
    

    enum Input {
        case logout
        case supportService
    }

    private let appSession: AppSession

    private var cancellables = Set<AnyCancellable>()

    init(
        appSession: AppSession
    ) {
        self.appSession = appSession
    }

    func handle(_ input: Input) {
        switch input {
        case .logout:
            appSession.handle(.logout(.init(needFlush: true, alert: .snack(message: "Вы разлогинились"))))
        case .supportService:
            callSupportService()
        }
    }

    private func callSupportService() {
        let phoneNumber = "88000000000"
        if let url = URL(string: "tel://\(phoneNumber)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                print("Can't open url on this device")
            }
        }
    }
}
