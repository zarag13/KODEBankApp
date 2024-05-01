//
//  HeaderDetailInfoCell.swift
//  AnyApp
//
//  Created by Kirill on 01.05.2024.
//

import UIKit
import UI
import AppIndependent

final class HeaderDetailInfoCell: BackgroundPrimary {

    // MARK: - Private Properties

    private let titleLabel = Label(foregroundStyle: .textTertiary, fontStyle: .body15sb)

    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
        body().embed(in: self)
    }

    // MARK: - Private methods

    private func body() -> UIView {
        BackgroundView(vPadding: 17, hPadding: 16) {
            titleLabel
                .fontStyle(.body15sb)
                .foregroundStyle(.textTertiary)
        }
        .backgroundStyle(.backgroundPrimary)
    }
}

// MARK: - Configurable

extension HeaderDetailInfoCell: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let title: String

        public static func == (lhs: HeaderDetailInfoCell.Props, rhs: HeaderDetailInfoCell.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(title)
        }
    }

    public func configure(with model: Props) {
        titleLabel.text(model.title)
    }
}
