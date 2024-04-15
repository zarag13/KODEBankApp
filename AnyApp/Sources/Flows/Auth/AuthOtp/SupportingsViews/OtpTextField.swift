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

    private var cancelable = [AnyCancellable]()
    private var labels = [Label]()
    private var tf = TextField()
    private var curentSelectedLabel = PassthroughSubject<Int, Never>()

    var otpEvent: ((Event) -> Void)?

    override func setup() {
        super.setup()
        body().embed(in: self)
    }

    private func body() -> UIView {
        tf = TextField(configurator: { tf in
            #warning("сделать отдельный метод для textContentType")
            tf.textContentType = .oneTimeCode
            let content = createStackLabelForTextField()
            tf.addSubview(content)
            content.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            tf.delegate = self
        })
            .tintColor(.clear)
            .textColor(.clear)
            .backgroundColor(.clear)
            .keyboardType(.numberPad)
        return tf
    }

    private func createStackLabelForTextField(count: Int = 6) -> UIView {
        if count % 2 == 0 {
            return HStack(alignment: .fill, distribution: .fillProportionally, spacing: 6) {
                ForEach(collection: 1...count / 2, distribution: .fillEqually, spacing: 6, axis: .horizontal) { value in
                    self.createLabelForTextField(tagForLineView: value)
                }
                createSeparatorForTextField()
                ForEach(collection: count/2 + 1...count, distribution: .fillEqually, spacing: 6, axis: .horizontal) { value in
                    self.createLabelForTextField(tagForLineView: value)
                }
            }
        } else {
            return HStack(alignment: .fill, distribution: .fillProportionally, spacing: 6) {
                ForEach(collection: 1...count, distribution: .fillEqually, spacing: 6, axis: .horizontal) { value in
                    self.createLabelForTextField(tagForLineView: value)
                }
                FlexibleSpacer()
                    .minWidth(40)
                    .minHeight(48)
            }
        }
    }

    private func createLabelForTextField(tagForLineView: Int) -> UIView {
        let view = BackgroundView()
            .minWidth(40)
            .minHeight(48)
            .huggingPriority(.defaultLow, axis: .horizontal)
            .backgroundColor( try? UIColor(hexString: "403A47"))
            .cornerRadius(12)
        let label = Label()
            .textAlignment(.center)
            .fontStyle(FontStyle.title)
            .textColor(.white)
        labels.append(label)
        view.addSubview(label)
        let lineView = UIView()
        lineView.backgroundColor = try? UIColor(hexString: "6C78E6")
        lineView.tag = tagForLineView
        lineView.isHidden = true
        view.addSubview(lineView)

        lineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(10)
            make.height.equalTo(2)
        }
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        curentSelectedLabel.sink { value in
            if lineView.tag == value {
                lineView.isHidden = false
            } else {
                lineView.isHidden = true
            }
        }.store(in: &cancelable)
        
        view.onTap {
            self.tf.becomeFirstResponder()
            let current = self.labels.first { label in
                label.text?.isEmpty == true
            }
            self.curentSelectedLabel.send(current?.tag ?? 1)
        }
        view.cornerRadius(12)
        return view
    }

    private func createSeparatorForTextField() -> UIView {
        BackgroundView { view in
            let lineView = UIView()
            lineView.backgroundColor = try? UIColor(hexString: "6C78E6")
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
