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
    private var leftImage: UIImage = Asset.Icon24px.back.image
    @Published private var rightImage: UIImage?

    override func setup() {
        super.setup()
        body().embed(in: self)
    }

    func body() -> UIView {
        HStack(alignment: .fill, distribution: .equalSpacing) {
            ImageView(image: leftImage)
                .huggingPriority(.defaultLow, axis: .horizontal)
                .onTap {
                    print("back")
                }
            createLable()
            createRightImage()
                .huggingPriority(.defaultLow, axis: .horizontal)
        }
            .layoutMargins(.make(vInsets: 10))
    }

    private func createLable() -> Label {
        let label = Label(text: title)
            .huggingPriority(.defaultHigh, axis: .horizontal)
            .textAlignment(.center)
            .textColor(.white)
        $title.sink { value in
            label.text = value
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
        $rightImage.sink { image in
            imageView.image = image
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
}
