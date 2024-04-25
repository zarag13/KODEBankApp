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
    private var cancelable = Set<AnyCancellable>()

    override func setup() {
        super.setup()
        setupBindings()
    }

    private func setupBindings() {
        otp.otpEvent = { [weak self] event in
            switch event {
            case .codeIsEntered(let code):
                self?.onOtpFilled?(code)
            case .inputTextStarted:
                if self?.timerLable.state.value == .error {
                    self?.timerLable.state.send(.process)
                }
            }
        }

        timerLable.state.sink { [weak self] state in
            if state == .process {
                self?.otp.handle(event: .correct)
            }
        }.store(in: &cancelable)
    }

    func handle(_ state: State) {
        switch state {
        case .error:
            timerLable.state.send(.error)
            otp.handle(event: .error)
        }
    }

    private func body(leght: Int) -> UIView {
        VStack {
            navigationBar
            VStack {
                Label(text: Entrance.authCodeSend, foregroundStyle: .textPrimary, fontStyle: .body15r)
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
