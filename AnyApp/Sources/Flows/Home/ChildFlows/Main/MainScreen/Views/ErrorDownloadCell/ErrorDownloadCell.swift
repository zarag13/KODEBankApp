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
    }

    // MARK: - Private methods

    private func body(with props: Props) -> UIView {
        VStack(alignment: .center, distribution: .fill) {
            //props.title
            Label(text: "Упс, что-то пошло не так", foregroundStyle: .textPrimary, fontStyle: .subtitle17sb)
            Spacer(.px6)
            //props.description
            Label(text: "Не удалось загрузить \nчасть контента", foregroundStyle: .textSecondary, fontStyle: .body15r)
                .textAlignment(.center)
                .linesCount(2)
            Spacer(.px16)
            //props.titleButton
            BackgroundView {
                errorLabel
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
        }
        .layoutMargins(.make(vInsets: 35.5, hInsets: 16))
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
            .backgroundColor(BackgroundStyle.backgroundSecondary.color)
    }
}
