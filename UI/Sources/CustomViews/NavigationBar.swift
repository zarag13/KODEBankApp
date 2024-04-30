import UIKit

public final class NavigationBar: BaseNavigationBar, Themeable {

    public enum Style {
        case clear
        case background
        case layer1
    }

    private var style: Style = .background

    override public func setup() {
        super.setup()
        subscribeOnThemeChanges()
        updateAppearance()
    }

    public func updateAppearance() {
        let standardAppearance = UINavigationBarAppearance()

        tintColor(Palette.Content.accentTertiary)

        let arrowImage = UIImage(named: "Icon24px/back") ?? UIImage()
            .withAlignmentRectInsets(.init(top: 0, left: -8, bottom: 0, right: 0))

        standardAppearance.setBackIndicatorImage(arrowImage, transitionMaskImage: arrowImage)

        standardAppearance.titleTextAttributes = [
            .foregroundColor: Palette.Text.primary,
            .font: Typography.subtitle17sb?.font ?? .preferredFont(forTextStyle: .headline)
        ]

//        standardAppearance.buttonAppearance.normal.titleTextAttributes = [
//            .font: Typography.caption2?.font ?? .preferredFont(forTextStyle: .headline)
//        ]
//        standardAppearance.doneButtonAppearance.normal.titleTextAttributes = [
//            .font: Typography.body15r?.font ?? .preferredFont(forTextStyle: .body)
//        ]

        standardAppearance.shadowColor = Palette.Shadow.dropShadow1

        let scrollEdgeAppearance = standardAppearance.copy()
        scrollEdgeAppearance.shadowColor = .clear

        switch style {
        case .background:
            scrollEdgeAppearance.backgroundColor = Palette.Surface.backgroundPrimary
            standardAppearance.backgroundColor = Palette.Surface.backgroundPrimary
        case .layer1:
            scrollEdgeAppearance.backgroundColor = Palette.Surface.backgroundPrimary
            standardAppearance.backgroundColor = Palette.Surface.backgroundPrimary
        case .clear:
            standardAppearance.configureWithTransparentBackground()
            scrollEdgeAppearance.configureWithTransparentBackground()
        }

        self.standardAppearance = standardAppearance
        self.scrollEdgeAppearance = scrollEdgeAppearance
    }
}

public extension NavigationBar {
    @discardableResult
    func style(_ style: Style) -> Self {
        self.style = style
        updateAppearance()
        return self
    }
}
