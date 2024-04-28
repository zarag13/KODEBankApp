//
//  SpinnerForAuthPhoneTF.swift
//  AnyApp
//
//  Created by Kirill on 28.04.2024.
//

import UIKit
import UI
import AppIndependent
import Core

final class SpinnerForAuthPhoneTF: BackgroundPrimary {

    // MARK: - Private Properties
    private var animator: UIViewPropertyAnimator?
    private let image = ImageView()

    override func setup() {
        super.setup()
        body().embed(in: self)
        self.backgroundStyle(.none)
    }

    // MARK: - Private Methods
    private func body() -> UIView {
        image
            .image(Asset.Icon24px.loader.image)
            .foregroundStyle(.contentAccentPrimary)
    }

    // MARK: - Public Methods
    public func start(_ reversed: Bool = false) {
        animator = UIViewPropertyAnimator(duration: 1, curve: .linear)
        animator?.addAnimations {
            self.transform = self.transform.rotated(by: .pi)
        }
        animator?.addCompletion { _ in
            self.start(!reversed)
        }
        animator?.startAnimation()
    }

    public func stop() {
        image.isHidden(true)
        animator?.stopAnimation(true)
        animator = nil
        self.transform = .identity
    }

    public func showImage() {
        image.isHidden(false)
    }
}
