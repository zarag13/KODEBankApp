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
    }
    enum State {
        case error
        case correct
    }

    var otpEvent: ((Event) -> Void)?

    private var cancelable = [AnyCancellable]()
    private var curentSelectedLabel = PassthroughSubject<Int, Never>()
    var state = CurrentValueSubject<State, Never>(.correct)

    private var labels = [Label]()
    private lazy var hiddenTextField: TextField = {
        TextField(configurator: { tf in
            tf.textContentType = .oneTimeCode
            tf.delegate = self
        })
        .tintColor(.clear)
        .textColor(.clear)
        .backgroundColor(.clear)
        .keyboardType(.numberPad)
    }()

    override func setup() {
        super.setup()
    }

    private func body(leght: Int) -> UIView {
        createStackLabelForTextField(count: leght)
    }

    public func configure(leght: Int) -> Self {
        body(leght: leght).embed(in: self)
        return self
    }
}

extension OtpTextField {

    private func createStackLabelForTextField(count: Int = 6) -> TextField {
        var stack = HStack()

        if count % 2 == 0 {
            stack = HStack(alignment: .center, distribution: .fill, spacing: 6) {
                ForEach(collection: 1...(count / 2), distribution: .fillEqually, spacing: 6, axis: .horizontal) { value in
                    self.setupLabel(tagForLineView: value)
                }
                createSeparatorForTextField()
                ForEach(collection: (count / 2 + 1)...count, distribution: .fillEqually, spacing: 6, axis: .horizontal) { value in
                    self.setupLabel(tagForLineView: value)
                }
            }
        } else {
            stack = HStack(alignment: .fill, distribution: .fill, spacing: 6) {
                ForEach(collection: 1...count, distribution: .fillEqually, spacing: 6, axis: .horizontal) { value in
                    self.setupLabel(tagForLineView: value)
                }
                FlexibleSpacer()
            }
        }
        hiddenTextField.addSubview(stack)
        if count == 6 {
            stack.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
            }
        } else {
            stack.snp.makeConstraints { make in
                make.left.top.bottom.equalToSuperview()
            }
        }

        stack
            .onTap { [weak self] in
                self?.hiddenTextField.becomeFirstResponder()
                let currentIndex = self?.labels.firstIndex { label in
                    label.text?.isEmpty == true
                }
                self?.curentSelectedLabel.send((currentIndex ?? (self?.labels.count ?? 1) - 1) + 1)
            }
        return hiddenTextField
    }

    private func setupLabel(tagForLineView: Int) -> Label {
        let label = Label(text: "")
            .minWidth(40)
            .minHeight(48)
            .cornerRadius(12)
            .clipsToBounds(true)
            .textAlignment(.center)
            .fontStyle(FontStyle.subtitle)
            .huggingPriority(.defaultLow, axis: .horizontal)
            .backgroundColor(ForegroundStyle.contentSecondary.color)
            .userInteraction(enabled: true)
        
        state.sink { [weak label]state in
            switch state {
            case .error:
                label?.foregroundStyle(.indicatorContentError)
            case .correct:
                label?.foregroundStyle(.textPrimary)
            }
        }.store(in: &cancelable)

        let lineView = BackgroundView()
        lineView.backgroundStyle(.indicatorContentSuccess)
        lineView.tag = tagForLineView
        lineView.isHidden = true
        curentSelectedLabel.sink { [weak lineView] value in
            if lineView?.tag == value {
                lineView?.isHidden = false
            } else {
                lineView?.isHidden = true
            }
        }.store(in: &cancelable)
        label.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.trailing.leading.equalToSuperview().inset(8)
            make.height.equalTo(2)
        }
        labels.append(label)
        return label
    }

    private func createSeparatorForTextField() -> UIView {
        BackgroundView { view in
            let lineView = UIView()
            lineView.backgroundColor = ForegroundStyle.contentTertiary.color
            view.addSubview(lineView)
            lineView.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(2)
            }
        }
        .width(10)
    }
}

extension OtpTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length == 1 {
            if textField.text?.count == labels.count {
                self.state.send(.correct)
            }
            textField.text?.removeLast()
        }
        guard textField.text?.count ?? 0 < labels.count else {
            return false
        }
        let newText = (textField.text ?? "") + string
        textField.text = newText
        for i in 0 ..< labels.count {
            let currentLabel = labels[i]
            if i < newText.count {
                let index = newText.index(newText.startIndex, offsetBy: i)
                currentLabel.text = String(newText[index])
                if i == labels.count - 1 {
                    hiddenTextField.resignFirstResponder()
                    otpEvent?(.codeIsEntered(hiddenTextField.text!))
                }
            } else {
                currentLabel.text?.removeAll()
            }
        }
        curentSelectedLabel.send((textField.text?.count ?? 0) + 1)
        return false
    }
}
