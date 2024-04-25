import UIKit
import UI
import AppIndependent

final class TemplateShimmerView: BackgroundPrimary {

    // MARK: - Public methods

    override public func setup() {
        super.setup()
        body().embed(in: self)
    }

    // MARK: - Private methods

    private func body() -> UIView {
        HStack(distribution: .fill, spacing: 16) {
            Shimmer(style: .default)
                .width(40)
                .skeletonCornerRadius(20)
            VStack(distribution: .fillProportionally, spacing: 8) {
                Shimmer(style: .default)
                    .skeletonCornerRadius(8)
                HStack {
                    Shimmer(style: .default)
                        .width(132)
                        .skeletonCornerRadius(6)
                    FlexibleSpacer()
                }
            }
        }
        .layoutMargins(.make(vInsets: 16, hInsets: 16))
        .height(72)
    }
}
