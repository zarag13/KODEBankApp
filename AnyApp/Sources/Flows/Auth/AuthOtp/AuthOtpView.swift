import UI
import UIKit
import AppIndependent
import Combine

final class AuthOtpView: BackgroundPrimary {
    typealias EventHandler = ((Event) -> Void)
    enum State {
        case error
        case clearCode
    }
    enum Event {
        case onOtpField(String)
        case onAttemptsFailed
        case refresh
    }

    // MARK: - Private Properties
    private let otp = OtpTextField()
    private let timerLable = TimerLabel()

    // MARK: - Public Properties
    public var onEvent: EventHandler?

    // MARK: - Private Methods
    override func setup() {
        super.setup()
        setupBindings()
    }

    private func body(leght: Int) -> UIView {
        VStack {
            Label(text: Entrance.authCodeSend, foregroundStyle: .textPrimary, fontStyle: .body15r)
                .linesCount(0)
            Spacer(.px24)
            otp
                .configure(leght: leght)
                .height(48)
            Spacer(.px8)
            timerLable
            FlexibleSpacer()
        }
        .layoutMargins(.make(vInsets: 16, hInsets: 16))
    }

    private func setupBindings() {
        otp.otpEvent = { [weak self] event in
            switch event {
            case .codeIsEntered(let code):
                self?.onEvent?(.onOtpField(code))
            case .inputTextStarted:
                self?.timerLable.handle(.process)
            }
        }

        timerLable.onEvent = { [weak self] event in
            switch event {
            case .attemptsFailed:
                self?.onEvent?(.onAttemptsFailed)
            case .process:
                self?.otp.handle(event: .correct)
            case .refresh:
                self?.otp.handleState(.disabled)
                self?.onEvent?(.refresh)
            }
        }
    }

    // MARK: - Public Methods
    func handle(_ state: State) {
        switch state {
        case .error:
            timerLable.handle(.error)
            otp.handle(event: .error)
        case .clearCode:
            otp.handle(event: .correct)
        }
    }

    public func configuration(otpLenght: Int) {
        subviews.forEach { $0.removeFromSuperview() }
        body(leght: otpLenght).embed(in: self)
    }

    public func updateConfiguration(otpLenght: Int) {
        self.subviews.forEach { $0.removeFromSuperview() }
        self.otp.handleState(.enabled)
        body(leght: otpLenght).embed(in: self)
        print(otp.stackLabels.labels.count)
        timerLable.handle(.process)
    }
}
