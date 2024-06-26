// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Profile {
  /// О приложении
  public static let aboutApp = Profile.tr("Profile", "aboutApp", fallback: "О приложении")
  /// Темная
  public static let dark = Profile.tr("Profile", "dark", fallback: "Темная")
  /// Выход
  public static let exit = Profile.tr("Profile", "exit", fallback: "Выход")
  /// Светлая
  public static let light = Profile.tr("Profile", "light", fallback: "Светлая")
  /// Служба поддержки
  public static let supportService = Profile.tr("Profile", "supportService", fallback: "Служба поддержки")
  /// Как в системе
  public static let system = Profile.tr("Profile", "system", fallback: "Как в системе")
  /// Тема приложения
  public static let themeApp = Profile.tr("Profile", "themeApp", fallback: "Тема приложения")
  /// Версия
  public static let version = Profile.tr("Profile", "version", fallback: "Версия")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Profile {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
