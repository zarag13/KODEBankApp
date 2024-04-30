//
//  BlurLoadingView.swift
//  AnyApp
//
//  Created by Kirill on 28.04.2024.
//

import UIKit
import AppIndependent
import UI

final class BlurEffectView: UIVisualEffectView {

    var animator = UIViewPropertyAnimator(duration: 0, curve: .linear)

    override func didMoveToSuperview() {
        guard let superview = superview else { return }
        backgroundColor = .clear
        setupBlur()
    }

    private func setupBlur() {
        animator.stopAnimation(true)
        effect = nil

        animator.addAnimations { [weak self] in
            self?.effect = UIBlurEffect(style: .dark)
        }
        animator.fractionComplete = 0.1
    }

    deinit {
        animator.stopAnimation(true)
    }
}

public final class BlurLoadingView: BackgroundPrimary {

    // MARK: - Private Properties

    private let spinner = MediumSpinner(style: .contentAccentPrimary)
    let blureView = BlurEffectView()

    // MARK: - Private methods
    override public func setup() {
        super.setup()
        self.embed(subview: blureView, useSafeAreaGuide: false)
        //body().embed(in: self)
        body().embed(in: self, useSafeAreaGuide: false)
        self.backgroundStyle(.none)
    }

    private func body() -> UIView {
        VStack {
            FlexibleGroupedSpacer()
            spinner
            FlexibleGroupedSpacer()
        }
        .linkGroupedSpacers()
    }

    public func close() {
        self.spinner.stop()
        self.removeFromSuperview()
    }

    public func open() {
        self.spinner.start()
    }
}
