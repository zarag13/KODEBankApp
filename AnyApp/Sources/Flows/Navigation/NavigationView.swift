//
//  NavigationView.swift
//  AnyApp
//
//  Created by Kirill on 16.04.2024.
//

import UI
import UIKit
import AppIndependent
import Combine

final class MainNavigationBar: BackgroundPrimary {

    @Published private var title: String?
    private var cancellable = Set<AnyCancellable>()
    private var leftImage = ImageView(image: Asset.Icon24px.back.image, foregroundStyle: .textPrimary)
    @Published private var rightImage: UIImage?
    private var navigationController: UINavigationController?

    override func setup() {
        super.setup()
        body().embed(in: self)
    }

    func body() -> UIView {
        HStack(alignment: .fill, distribution: .equalSpacing) {
            leftImage
                .height(24)
                .width(24)
                .huggingPriority(.defaultHigh, axis: .horizontal)
                .onTap { [weak self] in
                    print("back")
                    self?.navigationController?.popViewController(animated: true)
                }
            createLable()
            createRightImage()
        }
            .layoutMargins(.make(vInsets: 10))
    }

    private func createLable() -> Label {
        let label = Label(text: title)
            .huggingPriority(.defaultLow, axis: .horizontal)
            .textAlignment(.center)
            .foregroundStyle(.textPrimary)
            .fontStyle(.subtitle17sb)
        $title.sink { [weak label] value in
            label?.text = value
        }
            .store(in: &cancellable)
        return label
    }

    private func createRightImage() -> ImageView {
        let imageView = ImageView(image: rightImage)
            .height(24)
            .width(24)
            .huggingPriority(.defaultHigh, axis: .horizontal)
            .onTap {
                print("back")
            }
        $rightImage.sink { [weak imageView] image in
            imageView?.image = image
        }
        .store(in: &cancellable)
        return imageView
    }

    @discardableResult
    public func setuptile(title: String) -> Self {
        self.title = title
        return self
    }
    @discardableResult
    public func setupRightImage(image: UIImage) -> Self {
        self.rightImage = image
        return self
    }
    @discardableResult
    public func leftImageIsHidden() -> Self {
        self.leftImage.alpha = 0
        return self
    }
    @discardableResult
    public func popController(navigation: UINavigationController?) -> Self {
        navigationController = navigation
        return self
    }
}
