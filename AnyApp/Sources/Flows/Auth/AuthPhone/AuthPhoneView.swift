import UI
import UIKit
import AppIndependent
import Combine

final class AuthPhoneView: BackgroundPrimary {

    var onAuth: VoidHandler?
    var cancelable = [AnyCancellable]()

    let authPhoneTextField = AuthPhoneTextField()

    override func setup() {
        super.setup()
        body().embed(in: self)
        self.actionButton = ButtonPrimary(title: "Войти")
            .onTap { [weak self] in
                self?.authPhoneTextField.isActivate = .beginning
                self?.onAuth?()
            }
        self.moveActionButtonWithKeyboard = true
        self.onTap { [weak self] in
            self?.endEditing(true)
        }
    }

    private func body() -> UIView {
        VStack {
            Spacer(.px16)
            ImageView(image: Asset.logoS.image, foregroundStyle: .contentPrimary)
            Spacer(.px20)
            authPhoneTextField
            FlexibleGroupedSpacer()
        }
        .linkGroupedSpacers()
        .layoutMargins(.make(hInsets: 16))
    }
}
