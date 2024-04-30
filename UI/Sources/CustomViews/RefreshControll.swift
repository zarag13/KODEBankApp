//
//  RefreshControll.swift
//  UI
//
//  Created by Kirill on 30.04.2024.
//

import UIKit
import AppIndependent

// swiftlint:disable:next final_class
open class RefreshControll: UIRefreshControl, Themeable {

    public var onAction: VoidHandler?

    public private(set) var contentStyle: ForegroundStyle?

    public init(contentStyle: ForegroundStyle? = nil) {
        super.init(frame: .zero)
        subscribeOnThemeChanges()
        self.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func refresh() {
        self.onAction?()
    }

    @discardableResult
    public func contentStyle(_ contentStyle: ForegroundStyle) -> Self {
        self.contentStyle = contentStyle
        updateAppearance()
        return self
    }

    public func updateAppearance() {
        if let contentStyle {
            tintColor(contentStyle.color)
        }
    }
}
