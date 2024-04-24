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

    var otpEvent: ((Event) -> Void)?
    private var cancelable = Set<AnyCancellable>()

    lazy var hiddenTextField: TextField = {
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
    var stackLabels = StackLabelForOtpTextField()

    override func setup() {
        super.setup()
        setupBindings()
    }

    private func body(leght: Int) -> UIView {
        let finalConfigureTextField = BackgroundPrimary()
        stackLabels
            .configure(lenght: leght)
            .onTap { [weak self] in
                guard let textField = self?.hiddenTextField else { return }
                self?.activateKeyBoard(textField)
            }
        finalConfigureTextField.addSubview(hiddenTextField)
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

    public func configure(leght: Int) -> Self {
        body(leght: leght).embed(in: self)
        return self
    }

    private func setupBindings() {
        stackLabels.state.sink { [weak self] state in
            if state == .correct {
                self?.otpEvent?(.inputTextStarted)
            }
        }.store(in: &cancelable)
    }

    private func activateKeyBoard(_ textField: UITextField) {
        textField.becomeFirstResponder()
        let currentIndex = stackLabels.labels.firstIndex { label in
            label.text?.isEmpty == true
        }
        stackLabels.curentSelectedLabel.send((currentIndex ?? stackLabels.labels.count - 1) + 1)
    }

    public func handle(event: StackLabelForOtpTextField.State) {
        switch event {
        case .error:
            self.stackLabels.state.send(.error)
        case .correct:
            self.stackLabels.state.send(.correct)
        }
    }
}
