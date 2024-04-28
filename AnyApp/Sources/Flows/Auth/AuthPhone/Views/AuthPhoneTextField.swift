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
import Core

final class AuthPhoneTextField: BackgroundPrimary {
    enum AuthTFActivityIndicatorState {
        case beginning
        case stop
    }
    enum AuthTFState {
        case error
        case corrcet
    }

    // MARK: - Private Properties
    private var cancelable = Set<AnyCancellable>()
    private var isActivate = CurrentValueSubject<AuthTFActivityIndicatorState, Never>(.stop)
    private var state = CurrentValueSubject<AuthTFState, Never>(.corrcet)
    private var leftIcon = ImageView(image: Asset.Icon24px.phone.image, foregroundStyle: .indicatorContentSuccess)
    private let spinner = SpinnerForAuthPhoneTF()
    private lazy var authTF: TextField = {
        TextField(placeholder: Entrance.phone, configurator: { textField in
            textField.becomeFirstResponder()
            textField.textColor = ForegroundStyle.textPrimary.color
        })
            .huggingPriority(.defaultLow, axis: .horizontal)
            .keyboardType(.numberPad)
            .placeholderFontStyle(.body15r)
            .placeholderForegroundStyle(.textTertiary)
            .fontStyle(.body15r)
    }()

    // MARK: - Public Properties
    public var text: String = ""

    // MARK: - Private Methods
    override func setup() {
        super.setup()
        body().embed(in: self)
        setupBindings()
    }

    private func body() -> UIView {
        BackgroundView(leftPadding: 24, right: 16, top: 14, bottom: 14) {
            HStack(spacing: 16) {
                leftIcon
                    .huggingPriority(.defaultHigh, axis: .horizontal)
                authTF
                spinner
                    .width(24)
            }
        }
            .backgroundStyle(.contentPrimary)
            .cornerRadius(26)
    }

    private func setupBindings() {
        authTF.textPublisher
            .map { ($0.maskPhoneNumber(pattern: "+7 (###) ### ## ##")) }
            .assign(to: \.text, on: authTF)
            .store(in: &cancelable)
        authTF.textPublisher
            .sink { [weak self] text in
                self?.state.send(.corrcet)
                self?.text = text
            }.store(in: &cancelable)

        isActivate.sink { [weak self] state in
            switch state {
            case .beginning:
                self?.spinner.showImage()
                self?.spinner.start()
            case .stop:
                self?.spinner.stop()
            }
        }.store(in: &cancelable)

        state.sink { [weak self] value in
            self?.isActivate.send(.stop)
            switch value {
            case .error:
                self?.leftIcon
                    .foregroundStyle(.indicatorContentError)
                self?.authTF.textColor = ForegroundStyle.indicatorContentError.color
            case .corrcet:
                self?.leftIcon
                    .foregroundStyle(.indicatorContentSuccess)
                self?.authTF.textColor = ForegroundStyle.textPrimary.color
            }
        }
            .store(in: &cancelable)
    }

    // MARK: - Public Methods
    public func startAnimation() {
        self.isActivate.send(.beginning)
    }

    public func state(_ state: AuthTFState) {
        self.state.send(state)
    }
}
