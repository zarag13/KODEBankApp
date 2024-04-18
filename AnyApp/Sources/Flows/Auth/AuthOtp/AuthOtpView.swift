import UI
import UIKit
import AppIndependent
import Combine

final class AuthOtpView: BackgroundPrimary {

    var onOtpFilled: VoidHandler?

    private let otp = OtpTextField()
    
    override func setup() {
        super.setup()
        body().embed(in: self)
        otp.otpEvent = { [weak self] event in
            switch event {
            case .codeIsEntered:
                self?.onOtpFilled?()
            }
        }
    }

    private func body() -> UIView {
        VStack {
            MainNavigationBar()
            VStack {
                Label(text: "На ваш номер отправлено SMS с кодом подтверждения", foregroundStyle: .textPrimary, fontStyle: .body15r)
                    .linesCount(0)
                Spacer(.px24)
                otp
                    .height(48)
                Spacer(.px24)
                Label(text: "Повторить через 2:59", foregroundStyle: .textSecondary, fontStyle: .caption13)
            }
                .layoutMargins(.make(vInsets: 16))
            FlexibleSpacer()
            Spacer(.px32)
        }.layoutMargins(.make(vInsets: 16, hInsets: 16))
    }
}
