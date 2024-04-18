import UIKit

public enum Typography {

    public static let button = TextStyle(
        name: "button",
        size: 15,
        weight: .semibold,
        lineHeight: 18
    )
    
    public static let title = TextStyle(
        name: "title",
        size: 34,
        weight: .bold,
        lineHeight: 41
    )

    public static let largeTitle = TextStyle(
        name: "Large title",
        size: 28,
        weight: .medium,
        lineHeight: 34
    )

    public static let subtitle = TextStyle(
        name: "Subtitle",
        size: 20,
        weight: .semibold,
        lineHeight: 25
    )
    public static let subtitle17sb = TextStyle(
        name: "subtitle17sb",
        size: 17,
        weight: .semibold,
        lineHeight: 22
    )

    public static let body20r = TextStyle(
        name: "Body",
        size: 20,
        weight: .regular,
        lineHeight: 25
    )

    public static let body17m = TextStyle(
        name: "Body",
        size: 17,
        weight: .medium,
        lineHeight: 22
    )

    public static let body17r = TextStyle(
        name: "Body",
        size: 17,
        weight: .regular,
        lineHeight: 22
    )

    public static let body15r = TextStyle(
        name: "Body",
        size: 15,
        weight: .regular,
        lineHeight: 20
    )

    public static let body15sb = TextStyle(
        name: "Bdoy",
        size: 15,
        weight: .semibold,
        lineHeight: 20
    )

    public static let caption1 = TextStyle(
        name: "Caption 1",
        size: 13,
        weight: .regular,
        lineHeight: 16
    )

    public static let caption2 = TextStyle(
        name: "Caption 2",
        size: 11,
        weight: .regular,
        lineHeight: 13
    )
}
