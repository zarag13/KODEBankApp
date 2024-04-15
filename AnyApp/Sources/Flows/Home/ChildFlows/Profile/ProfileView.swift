import UI
import UIKit
import AppIndependent

final class ProfileView: BackgroundPrimary {

    var onLogout: VoidHandler?

    let detailInfoView = DetailInfoView()
    let settingsStackView = SettingsStackView()

    override func setup() {
        super.setup()
        body().embed(in: self)
    }

    private func body() -> UIView {
        VStack {
            NavigationBar()
                .height(52)
            detailInfoView
            View()
                .height(50)
            settingsStackView
            FlexibleSpacer()
            //Spacer(.px32)
//            ButtonPrimary(title: "Разлогиниться")
//                .onTap { [weak self] in
//                    self?.onLogout?()
//                }
        }.layoutMargins(.make(vInsets: 16, hInsets: 16))
    }
}
