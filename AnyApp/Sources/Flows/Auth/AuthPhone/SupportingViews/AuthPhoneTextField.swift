//
//  AuthPhoneTextField.swift
//  AnyApp
//
//  Created by Kirill on 14.04.2024.
//
import UIKit
import UI
import AppIndependent
import Combine

final class AuthPhoneTextField: BackgroundPrimary {
    enum AuthTFActivityIndicatorState {
        case beginning
        case stop
    }
    enum AuthTFState {
        case error
        case corrcet
    }
    // Published
    private var cancelable = Set<AnyCancellable>()
    @Published var isActivate: AuthTFActivityIndicatorState = .stop
    var state = CurrentValueSubject<AuthTFState, Never>(.corrcet)

    public var text: String = ""

    // UI
    private var leftIcon = ImageView(image: Asset.Icon24px.phone.image, foregroundStyle: .indicatorContentSuccess)
    private let spinner = MediumSpinner(style: .contentAccentPrimary)
    private lazy var authTF: TextField = {
        TextField(placeholder: "Телефон", configurator: { textField in
            textField.becomeFirstResponder()
            textField.textColor = ForegroundStyle.textPrimary.color
            textField.textPublisher
                .map { ($0.formatUserInput(pattern: "+7 (###) ### ## ##" )) }
                .assign(to: \.text, on: textField)
                .store(in: &cancelable)
            textField.textPublisher
                .sink { text in
                    self.state.send(.corrcet)
                    self.text = text
                }.store(in: &cancelable)
        })
            .huggingPriority(.defaultLow, axis: .horizontal)
            .keyboardType(.numberPad)
            .placeholderFontStyle(.body15r)
            .placeholderForegroundStyle(.textTertiary)
            .fontStyle(.body15r)
    }()

    override func setup() {
        super.setup()
        body().embed(in: self)
        $isActivate.sink { [weak self] state in
            switch state {
            case .beginning:
                self?.spinner.isHidden = false
                self?.spinner.start()
            case .stop:
                self?.spinner.isHidden = true
                self?.spinner.stop()
            }
        }
            .store(in: &cancelable)
        #warning("Добавить нормальные цвета ошибки ввода и нормалоьного цвета")
        state.sink { value in
            self.isActivate = .stop
            switch value {
            case .error:
                self.leftIcon
                    .foregroundStyle(.indicatorContentError)
                self.authTF.textColor = ForegroundStyle.indicatorContentError.color
            case .corrcet:
                self.leftIcon
                    .foregroundStyle(.indicatorContentSuccess)
                self.authTF.textColor = ForegroundStyle.textPrimary.color
            }
        }
            .store(in: &cancelable)
    }

    private func body() -> UIView {
        VStack {
            HStack(spacing: 16) {
                leftIcon
                    .huggingPriority(.defaultHigh, axis: .horizontal)
                authTF
                spinner
                    .huggingPriority(.defaultHigh, axis: .horizontal)
            }
            .layoutMargins(.init(top: 14, left: 24, bottom: 14, right: 16))
        }
            .backgroundColor(ForegroundStyle.contentPrimary.color)
            .cornerRadius(26)
    }
}
