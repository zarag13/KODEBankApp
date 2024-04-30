//
//  DetailInfoView.swift
//  AnyApp
//
//  Created by Kirill on 15.04.2024.
//

import UI
import UIKit
import AppIndependent
import Combine

final class DetailInfoView: BackgroundPrimary {
    // MARK: - Private Properties
    private var phoneState = CurrentValueSubject<Model.PhoneState, Never>(.close)
    private var cancelable = Set<AnyCancellable>()

    override func setup() {
        super.setup()
    }

    // MARK: - Private Methods
    private func body(props: Model) -> UIView {
        VStack {
            View()
                .height(52)
            ImageView(image: props.avatar)
                .huggingPriority(.defaultHigh, axis: .horizontal)
            Spacer(.px16)
            Label(text: props.fullName)
                .fontStyle(.subtitle17sb)
                .foregroundStyle(.textPrimary)
                .textAlignment(.center)
                .multiline()
            createPhoneLabnel(props: props)
            View()
                .height(46)
        }
    }
    private func createPhoneLabnel(props: Model) -> UIView {
        let phoneLabel = Label()
            .fontStyle(.caption11)
            .textAlignment(.center)
            .foregroundStyle(.textSecondary)

        phoneState.sink { [weak phoneLabel] state in
            switch state {
            case .open:
                phoneLabel?.text(props.togglePhoneMask(state: .open))
            case .close:
                phoneLabel?.text(props.togglePhoneMask(state: .close))
            }
        }.store(in: &cancelable)

        return BackgroundView(vPadding: 4) {
            phoneLabel
        }
        .onTap { [weak self] in
            self?.phoneState.value == .close ? self?.phoneState.send(.open) : self?.phoneState.send(.close)
        }
    }}

extension DetailInfoView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {

        enum PhoneState {
            case open
            case close
        }

        private let id: Int
        private let firstName: String
        private let middleName: String
        private let lastName: String
        private let country: String
        private let phone: String
        public let avatar: UIImage

        public static func == (lhs: DetailInfoView.Props, rhs: DetailInfoView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(firstName)
            hasher.combine(middleName)
            hasher.combine(lastName)
            hasher.combine(phone)
            hasher.combine(avatar)
        }

        init(id: Int, firstName: String, middleName: String, lastName: String, country: String, phone: String, avatar: UIImage) {
            self.id = id
            self.firstName = firstName
            self.middleName = middleName
            self.lastName = lastName
            self.country = country
            self.phone = phone
            self.avatar = avatar
        }

        public var fullName: String {
            return "\(firstName) \(lastName) \(middleName)"
        }

        func togglePhoneMask(state: PhoneState) -> String {
            switch state {
            case .open:
                return phone.maskPhoneNumber(pattern: "+7 (###) ### - ## - ##")
            case .close:
                return phone.maskPhoneNumber(pattern: "+7 (###) *** - ** - ##")
            }
        }
    }

    public func configure(with model: Model) {
        subviews.forEach { $0.removeFromSuperview() }
        body(props: model).embed(in: self)
        self.layoutIfNeeded()
    }
}
