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
        case codeIsEntered
    }

    var otpEvent: ((Event) -> Void)?

    private var cancelable = [AnyCancellable]()
    private var curentSelectedLabel = PassthroughSubject<Int, Never>()

    private var labels = [Label]()
    private lazy var tf: TextField = {
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
        body().embed(in: self)
    }

    private func body() -> UIView {
        ZStack(positioningMode: .fill) {
            HStack {
                tf
            }
            HStack(distribution: .fill) {
                createStackLabelForTextField()
                FlexibleSpacer()
            }
        }
    }

    private func createStackLabelForTextField(count: Int = 6) -> UIView {
        if count % 2 == 0 {
            return HStack(distribution: .fill, spacing: 6) {
                ForEach(collection: 1...(count / 2), distribution: .fillEqually, spacing: 6, axis: .horizontal) { value in
                    self.createLabelForTextField(tagForLineView: value)
                }
                createSeparatorForTextField()
                ForEach(collection: (count / 2 + 1)...count, distribution: .fillEqually, spacing: 6, axis: .horizontal) { value in
                    self.createLabelForTextField(tagForLineView: value)
                }
            }
        } else {
            return HStack(alignment: .fill, distribution: .fillProportionally, spacing: 6) {
                ForEach(collection: 1...count, distribution: .fillEqually, spacing: 6, axis: .horizontal) { value in
                    self.createLabelForTextField(tagForLineView: value)
                }
            }
        }
    }

    private func createLabelForTextField(tagForLineView: Int) -> UIView {
        ZStack(positioningMode: .fill) {
            VStack() {
                setupLabel()
            }
            VStack(alignment: .fill) {
                FlexibleSpacer()
                BackgroundView(configurator: { view in
                    view.tag = tagForLineView
                    curentSelectedLabel.sink { value in
                        if view.tag == value {
                            view.isHidden = false
                        } else {
                            view.isHidden = true
                        }
                    }.store(in: &cancelable)
                })
                .backgroundStyle(.indicatorContentSuccess)
                    .height(2)
                    .isHidden(true)
            }
                .layoutMargins(.make(vInsets: 10, hInsets: 8))
                .onTap {
                    self.tf.becomeFirstResponder()
                    let currentIndex = self.labels.firstIndex { label in
                        label.text?.isEmpty == true
                    }
                    self.curentSelectedLabel.send((currentIndex ?? 0) + 1)
                }
        }
    }
    private func setupLabel() -> Label {
        let label = Label(text: "")
            .minWidth(40)
            .minHeight(48)
            .cornerRadius(12)
            .clipsToBounds(true)
            .textAlignment(.center)
            .fontStyle(FontStyle.subtitle)
            .huggingPriority(.defaultLow, axis: .horizontal)
            .backgroundColor(ForegroundStyle.contentSecondary.color)
            .foregroundStyle(.textPrimary)
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
                    tf.resignFirstResponder()
                    otpEvent?(.codeIsEntered)
                }
            } else {
                currentLabel.text?.removeAll()
            }
        }
        curentSelectedLabel.send((textField.text?.count ?? 0) + 1)
        return false
    }
}
