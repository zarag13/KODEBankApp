//
//  ErrorDownloadCell.swift
//  AnyApp
//
//  Created by Kirill on 25.04.2024.
//

import UIKit
import UI
import AppIndependent

final class ErrorDownloadCell: BackgroundPrimary {
    private var errorLabel = Label(text: "Обновить", foregroundStyle: .contentAccentPrimary, fontStyle: .body15sb)

    // MARK: - Public methods

    override public func setup() {
        super.setup()
        self.backgroundStyle(.backgroundPrimary)
    }

    // MARK: - Private methods

    private func body(with props: Props) -> UIView {
        VStack(alignment: .center, distribution: .fill) {
            Spacer(.px36)
            Label(text: "Упс, что-то пошло не так", foregroundStyle: .textPrimary, fontStyle: .subtitle17sb)
                .textAlignment(.center)
            Spacer(.px6)
            Label(text: "Не удалось загрузить \nчасть контента", foregroundStyle: .textSecondary, fontStyle: .body15r)
                .textAlignment(.center)
                .multiline()
            Spacer(.px16)
            BackgroundView(vPadding: 1, hPadding: 1) {
                errorLabel
                    .textAlignment(.center)
            }
            .onTap { [weak self] in
                UIView.animate(withDuration: 0.1) {
                    self?.errorLabel.alpha = 0.2
                } completion: { _ in
                    UIView.animate(withDuration: 0.1) {
                        self?.errorLabel.alpha = 1
                    }
                }
            }
            Spacer(.px36)
        }
        .layoutMargins(.make( hInsets: 16))
    }
}

// MARK: - Configurable
extension ErrorDownloadCell: ConfigurableView {
    typealias Model = Props

    struct Props: Hashable {
        let id: String
        let title: String
        let description: String
        let titleButton: String
        var onTap: StringHandler?

        public static func == (lhs: ErrorDownloadCell.Props, rhs: ErrorDownloadCell.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(description)
            hasher.combine(titleButton)
        }
    }

    public func configure(with model: Props) {
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}
