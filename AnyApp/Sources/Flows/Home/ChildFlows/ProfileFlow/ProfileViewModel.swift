import Services
import Combine
import UIKit

final class ProfileViewModel {
    enum Input {
        case logout
        case supportService
        case loadView
    }

    enum Output {
        case detailProfileData(DetailInfoView.Props)
    }

    private let appSession: AppSession
    private let authRequestManager: ProfiletManagerAbstract
    private var cancellables = Set<AnyCancellable>()

    public var onOutput: ((Output) -> Void)?

    init(
        appSession: AppSession,
        authRequestManager: ProfiletManagerAbstract
    ) {
        self.appSession = appSession
        self.authRequestManager = authRequestManager
    }

    private func getDataProfile() {
        authRequestManager.profileData().sink { _ in
            // TODO: handle error
        } receiveValue: { value in
            self.onOutput?(.detailProfileData(.init(id: value.id, firstName: value.firstName, middleName: value.middleName, lastName: value.lastName, country: value.country, phone: value.phone, avatar: Asset.bitmap.image)))
        }.store(in: &cancellables)
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

    func handle(_ input: Input) {
        switch input {
        case .logout:
            appSession.handle(.logout(.init(needFlush: true, alert: .snack(message: "Вы разлогинились"))))
        case .supportService:
            callSupportService()
        case .loadView:
            getDataProfile()
        }
    }
}
