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
        case correct
        case openKeyboard
    }

    // MARK: - Private Properties
    private let authPhoneTextField = AuthPhoneTextField()

    // MARK: - Public Properties
    public var onEvent: ((Output) -> Void)?

    // MARK: - Private Methods
    override func setup() {
        super.setup()
        body().embed(in: self)

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

    // MARK: - Public Methods
    public func handle(_ event: Input) {
        self.actionButton?.userInteraction(enabled: true)
        switch event {
        case .incorrectNumber:
            self.authPhoneTextField.state(.error)
        case .correct:
            self.authPhoneTextField.state(.corrcet)
        case .openKeyboard:
            self.authPhoneTextField.openKeyboard()
        }
    }
}
