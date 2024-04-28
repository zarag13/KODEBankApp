//
//  OtpTextField.swift
//  AnyApp
//
//  Created by Kirill on 14.04.2024.
//

import UI
import UIKit
import AppIndependent
import Combine

final class OtpTextField: BackgroundPrimary {
    enum Event {
        case codeIsEntered(String)
        case inputTextStarted
    }
    enum State {
        case disabled
        case enabled
    }

    // MARK: - Private Properties
    private var cancelable = Set<AnyCancellable>()
    private lazy var hiddenTextField: TextField = {
        TextField(configurator: { tf in
            tf.textContentType = .oneTimeCode
            tf.delegate = self
            activateKeyBoard(tf)
        })
        .tintColor(.clear)
        .textColor(.clear)
        .backgroundColor(.clear)
        .keyboardType(.numberPad)
    }()

    // MARK: - Public Properties
    var otpEvent: ((Event) -> Void)?
    var stackLabels = StackLabelForOtpTextField()

    // MARK: - Private Metods
    override func setup() {
        super.setup()
    }

    private func body(leght: Int) -> UIView {
        let finalConfigureTextField = BackgroundView()
        stackLabels
            .configure(lenght: leght)
            .onTap { [weak self] in
                guard let textField = self?.hiddenTextField else { return }
                self?.activateKeyBoard(textField)
            }
        stackLabels.insertSubview(hiddenTextField, at: 0)
        finalConfigureTextField.addSubview(stackLabels)
        hiddenTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        if leght == 6 {
            stackLabels.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
            }
        } else {
            stackLabels.snp.makeConstraints { make in
                make.left.top.bottom.equalToSuperview()
            }
        }
        return finalConfigureTextField
    }

    private func activateKeyBoard(_ textField: UITextField) {
        textField.becomeFirstResponder()
        let currentIndex = stackLabels.labels.firstIndex { label in
            label.text?.isEmpty == true
        }
        stackLabels.handleSelectedLable((currentIndex ?? stackLabels.labels.count - 1) + 1)
    }

    // MARK: - Public Metods
    public func configure(leght: Int) -> Self {
        self.subviews.forEach { $0.removeFromSuperview() }
        body(leght: leght).embed(in: self)
        return self
    }

    public func handle(event: StackLabelForOtpTextField.State) {
        switch event {
        case .error:
            self.stackLabels.handle(.error)
        case .correct:
            self.stackLabels.handle(.correct)
            self.stackLabels.labels.forEach { ($0.text = "") }
            self.hiddenTextField.text = nil
            self.hiddenTextField.becomeFirstResponder()
            self.stackLabels.handleSelectedLable(1)
        }
    }

    public func handleState(_ state: State) {
        switch state {
        case .disabled:
            self.hiddenTextField.userInteraction(enabled: false)
        case .enabled:
            self.hiddenTextField.userInteraction(enabled: true)
        }
    }
}
