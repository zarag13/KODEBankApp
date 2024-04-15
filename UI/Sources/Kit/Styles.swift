import UIKit

// Defines background color
public enum BackgroundStyle {
    case none

    case backgroundPrimary
}

// Defines textColor and tintColor
public enum ForegroundStyle {
    case none

    case contentPrimary
    case textPrimary

    case button
}

// Defines borderColor
public enum BorderStyle {
    case none
    case template // Remove after 3-d lection
}

// Defines font
public enum FontStyle {
    case title
    case button
}

// Defines shadow properties
public enum ShadowStyle {
    case dropShadow1
}

// Defines gradient properties
public enum GradientStyle {
    case none
    case gradient1
}

public extension BackgroundStyle {

    var color: UIColor {
        switch self {
        case .none:
            UIColor.clear
        case .backgroundPrimary:
            Palette.Surface.backgroundPrimary
        }
    }
}

public extension ForegroundStyle {

    var color: UIColor {
        switch self {
        case .none:
            UIColor.clear
        case .contentPrimary:
            Palette.Content.primary
        case .textPrimary:
            Palette.Text.primary
        case .button:
            Palette.Button.buttonText
        }
    }
}

public extension BorderStyle {

    var color: UIColor {
        switch self {
        case .none:
            UIColor.clear
        case .template:
            UIColor.red
        }
    }
}

public extension FontStyle {

    var textStyle: TextStyle? {
        switch self {
        case .title:
            Typography.title
        case .button:
            Typography.button
        }
    }
}

public extension ShadowStyle {

    var shadowProps: ShadowProps {
        switch self {
        case .dropShadow1:
            return ShadowProps(radius: 16, color: Palette.Shadow.dropShadow1, offsetX: 0, offsetY: 8)
        }
    }
}

public extension GradientStyle {

    var gradientProps: GradientProps? {
        switch self {
        case .none:
            nil
        case .gradient1:
            Palette.Gradient.gradient1
        }
    }
}
