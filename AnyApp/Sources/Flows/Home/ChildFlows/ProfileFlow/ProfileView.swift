import UI
import UIKit
import AppIndependent

final class ProfileView: BackgroundPrimary {
    typealias StateView = ((State) -> Void)

    enum State {
        case isBeingDownloadData
        case hasBeenDownloadData
    }

    enum Event {
        case onLogout
        case onThemeApp
        case onAboutApp
        case supportService
        case exit
    }

    var event: ((Event) -> Void)?

    var state: StateView?

    let detailInfoView = DetailInfoView()
    let settingsStackView = SettingsStackView()
    let shimer = SettingsShimerStackView()
    let shimer2 = ShimmerDetailInfoView()

    override func setup() {
        super.setup()
        state = { [weak self] state in
            guard let strSelf = self else { return }
            switch state {
            case .isBeingDownloadData:
                strSelf.shimmerBody().embed(in: strSelf)
            case .hasBeenDownloadData:
                strSelf.shimmerBody().removeFromSuperview()
                strSelf.contentBody().embed(in: strSelf)
            }
        }
        setupBindings()
    }

    private func contentBody() -> UIView {
        VStack {
            detailInfoView
            settingsStackView
        }
        .layoutMargins(.make(hInsets: 16))
    }

    private func shimmerBody() -> UIView {
        VStack {
            shimer2
            shimer
        }.layoutMargins(.make(hInsets: 16))
    }

    func setupBindings() {
        settingsStackView.action = { value in
            switch value {
            case .aboutApp:
                self.event?(.onAboutApp)
            case .themeApp:
                self.event?(.onThemeApp)
            case .supportService:
                self.event?(.supportService)
            case .exit:
                self.event?(.exit)
            }
        }
    }
}
