import UI
import UIKit
import AppIndependent
import Combine

final class ProfileView: BackgroundPrimary {
    typealias StateView = ((State) -> Void)
    typealias SettingViewAction = ((ModelSettingsView.Event) -> Void)

    enum State {
        case isBeingDownloadData
        case hasBeenDownloadData(DetailInfoView.Props)
    }

    private var cancelable = Set<AnyCancellable>()
    private var state = CurrentValueSubject<State, Never>(.isBeingDownloadData)

    private let detailInfoView = DetailInfoView()
    private let settingsStackView = SettingsStackView()
    private let shimerSettings = SettingsShimerStackView()
    private let shimerDetail = ShimmerDetailInfoView()

    public var event: SettingViewAction?

    override func setup() {
        super.setup()
        setupBindings()
    }

    private func contentBody() -> UIView {
        return VStack {
            detailInfoView
            settingsStackView
        }
        .layoutMargins(.make(hInsets: 16))
    }

    private func shimmerBody() -> UIView {
        VStack {
            shimerDetail
            shimerSettings
        }.layoutMargins(.make(hInsets: 16))
    }

    private func setupBindings() {
        settingsStackView.action = { [weak self] event in
            self?.event?(event)
        }
        
        state.sink { [weak self] state in
            switch state {
            case .isBeingDownloadData:
                self?.shimmerBody().embed(in: self ?? UIView())
            case .hasBeenDownloadData(let props):
                self?.shimmerBody().removeFromSuperview()
                self?.detailInfoView.configured(with: props)
                self?.contentBody().embed(in: self ?? UIView())
            }
        }.store(in: &cancelable)
    }

    public func handle(_ state: State) {
        self.state.send(state)
    }
}
