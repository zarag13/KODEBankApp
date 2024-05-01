import Services
import Combine
import UIKit
import UI

final class ProfileViewModel: NetworkErrorHandler {
    typealias Props = ProfileViewProps
    enum Input {
        case loadView
        case resfresh
        case logout
    }

    enum Output {
        case content(Props)
        case error(ErrorView.Props, Props.Section)
        case noInternet(UIAlertController)
        case openSetiings(SettingView.Event)
        case errorViewClosed
    }

    // MARK: - Privaet Properties
    private let appSession: AppSession
    private let coreRequestManager: CoreManagerAbstract
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Public Properties
    public var onOutput: ((Output) -> Void)?

    init(
        appSession: AppSession,
        authRequestManager: CoreManagerAbstract
    ) {
        self.appSession = appSession
        self.coreRequestManager = authRequestManager
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

    // MARK: - Privaet Methods

    private func createShimmerList() -> ProfileViewProps {
        return .init(sections: [
            .detailHeader([
                .detailInfoShimmer()
            ]),
            .settings((1...4).map { _ in .settingShimmer() })
        ])
    }

    private func createSettingsList() -> ProfileViewProps.Section {
        func openSettings(event: SettingView.Event) {
            self.onOutput?(.openSetiings(event))
        }
        return .settings([
            .settings(.init(id: 1, title: Profile.aboutApp, event: .aboutApp, leftImage: Asset.Icon24px.settings.image, isDetailedImage: true, onTap: openSettings)),
            .settings(.init(id: 2, title: Profile.themeApp, event: .themeApp, leftImage: Asset.Icon24px.phoneCall.image, isDetailedImage: true, onTap: openSettings)),
            .settings(.init(id: 3, title: Profile.supportService, event: .supportService, leftImage: Asset.Icon24px.settings.image, isDetailedImage: false, onTap: { [weak self] _ in
                self?.callSupportService()
            })),
            .settings(.init(id: 4, title: Profile.exit, event: .exit, leftImage: Asset.Icon24px.accountOut.image, isDetailedImage: false, onTap: openSettings))
        ])
    }

    private func getDataProfile() {
        coreRequestManager.profileData().sink { [weak self] error in
            guard case let .failure(error) = error else { return }
            guard let errorProps = self?.errorHandle(
                error,
                onTap: {
                if error.appError.kind == .timeout {
                    self?.checkInternet(returnAlert: { alert in
                        self?.onOutput?(.noInternet(alert))
                    }, returnIsOn: {
                        self?.getDataProfile()
                    })
                } else {
                    self?.getDataProfile()
                }
            }, 
                closeTap: {
                self?.onOutput?(.errorViewClosed)
            }) else { return }
            guard let section = self?.createSettingsList() else { return }
            self?.onOutput?(.error(errorProps, section))
        } receiveValue: { [weak self] value in
            guard let section = self?.createSettingsList() else { return }
            self?.onOutput?(.content(.init(sections: [
                .detailHeader([
                    .detailInfo(.init(id: value.id, firstName: value.firstName, middleName: value.middleName, lastName: value.lastName, country: value.country, phone: value.phone, avatar: Asset.bitmap.image))
                ]),
                section
            ])))
        }.store(in: &cancellables)
    }

    // MARK: - Public Methods
    public func handle(_ input: Input) {
        switch input {
        case .loadView:
            self.onOutput?(.content(self.createShimmerList()))
            self.getDataProfile()
        case .resfresh:
            self.getDataProfile()
        case .logout:
            self.appSession.handle(.logout(.init(needFlush: true, alert: .snack(message: "Вы разлогинились"))))
        }
    }
}
