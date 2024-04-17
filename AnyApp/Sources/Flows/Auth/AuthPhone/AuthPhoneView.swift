import UI
import UIKit
import AppIndependent
import Combine

final class AuthPhoneView: BackgroundPrimary {
    enum Event {
        case corect
        case incorrect
    }
    // Actions
    var onEvent: ((Event) -> Void)?
    var onAuth: StringHandler?
    // Published
    private var cancelable = Set<AnyCancellable>()
    // UI
    private let authPhoneTextField = AuthPhoneTextField()

    override func setup() {
        super.setup()
        body().embed(in: self)
        onTap { [weak self] in
            self?.endEditing(true)
        }

        onEvent = { event in
            switch event {
            case .corect:
                self.authPhoneTextField.state.send(.corrcet)
            case .incorrect:
                self.authPhoneTextField.state.send(.error)
            }
        }

//        actionButton = ButtonPrimary(title: "Войти")
//            .onTap { [weak self] in
//                self?.authPhoneTextField.isActivate = .beginning
//                self?.onAuth?(self?.authPhoneTextField.text ?? "")
//            }
//        moveActionButtonWithKeyboard = true
    }

    private func body() -> UIView {
        VStack(spacing: 20) {
            ImageView(image: Asset.logoS.image, foregroundStyle: .contentPrimary)
            authPhoneTextField
            FlexibleGroupedSpacer()
        }
        .linkGroupedSpacers()
        .layoutMargins(.make(vInsets: 16, hInsets: 16))
    }
    
    
    
    private func body2() -> UIView {
        let about = AboutAppView()
        return about
    }
}
