import UI
import UIKit
import AppIndependent
import Combine

final class AuthPhoneView: BackgroundPrimary {
    enum Output {
        case onLogin(String)
    }
    enum Input {
        case incorrectNumber
    }

    // Actions
    var onEvent: ((Output) -> Void)?
    // UI
    private let authPhoneTextField = AuthPhoneTextField()
    
    override func setup() {
        super.setup()
        body().embed(in: self)
//        onTap { [weak self] in
//            self?.endEditing(true)
//        }

        actionButton = ButtonPrimary(title: Entrance.enter)
            .onTap { [weak self] in
                self?.actionButton?.userInteraction(enabled: false)
                self?.authPhoneTextField.startAnimation()
                self?.onEvent?(.onLogin(self?.authPhoneTextField.text ?? ""))
            }
        moveActionButtonWithKeyboard = true
    }

    private func body() -> UIView {
        VStack(spacing: 20) {
            ImageView(image: Asset.logoS.image, foregroundStyle: .contentAccentTertiary)
            authPhoneTextField
                .roundingFiftyPercentFromHeight()
            FlexibleGroupedSpacer()
        }
        .linkGroupedSpacers()
        .layoutMargins(.make(vInsets: 16, hInsets: 16))
    }

    public func handle(_ event: Input) {
        self.actionButton?.userInteraction(enabled: true)
        switch event {
        case .incorrectNumber:
            self.authPhoneTextField.state(.error)
        }
    }
}
