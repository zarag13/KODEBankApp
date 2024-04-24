import UI
import UIKit
import AppIndependent
import Combine

final class AuthOtpView: BackgroundPrimary {
    enum State {
        case error
    }
    var onOtpFilled: StringHandler?

    private let otp = OtpTextField()
    let navigationBar = MainNavigationBar()
    private let timerLable = TimerLabel()

    override func setup() {
        super.setup()
        otp.otpEvent = { [weak self] event in
            switch event {
            case .codeIsEntered(let code):
                self?.onOtpFilled?(code)
            }
        }
    }

    func handle(_ state: State) {
        switch state {
        case .error:
            timerLable.state.send(.error)
            otp.state.send(.error)
        }
    }

    private func body(leght: Int) -> UIView {
        VStack {
            navigationBar
            VStack {
                Label(text: "На ваш номер отправлено SMS с кодом подтверждения", foregroundStyle: .textPrimary, fontStyle: .body15r)
                    .linesCount(0)
                Spacer(.px24)
                otp
                    .configure(leght: leght)
                    .height(48)
                Spacer(.px8)
                timerLable
            }
                .layoutMargins(.make(vInsets: 16))
            FlexibleSpacer()
            Spacer(.px32)
        }.layoutMargins(.make(vInsets: 16, hInsets: 16))
    }

    public func configure(leght: Int) {
        body(leght: leght).embed(in: self)
    }
}
