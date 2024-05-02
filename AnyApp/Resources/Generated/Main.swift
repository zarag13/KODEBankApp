// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Main {
  /// Счета
  public static let accounts = Main.tr("Main", "accounts", fallback: "Счета")
  /// Вклады
  public static let deposits = Main.tr("Main", "deposits", fallback: "Вклады")
  /// Счет расчетный
  public static let detailAccount = Main.tr("Main", "detailAccount", fallback: "Счет расчетный")
  /// Подробный просмотр истории, временно не доступен
  public static let detailHistory = Main.tr("Main", "detailHistory", fallback: "Подробный просмотр истории, временно не доступен")
  /// Функция находится в разработке
  public static let featureInDevelopment = Main.tr("Main", "featureInDevelopment", fallback: "Функция находится в разработке")
  /// Главная
  public static let main = Main.tr("Main", "main", fallback: "Главная")
  /// Функция временно не доступна
  public static let newProducts = Main.tr("Main", "newProducts", fallback: "Функция временно не доступна")
  /// Платежи
  public static let payments = Main.tr("Main", "payments", fallback: "Платежи")
  public enum Account {
    /// Закрыть счет
    public static let close = Main.tr("Main", "account.close", fallback: "Закрыть счет")
    /// Реквизиты счета
    public static let details = Main.tr("Main", "account.details", fallback: "Реквизиты счета")
    /// ЖКХ
    public static let hcs = Main.tr("Main", "account.hcs", fallback: "ЖКХ")
    /// Интернет
    public static let internet = Main.tr("Main", "account.internet", fallback: "Интернет")
    /// Привязанные карты
    public static let linkedCards = Main.tr("Main", "account.linkedCards", fallback: "Привязанные карты")
    /// Мобильная связь
    public static let mobileCommunication = Main.tr("Main", "account.mobileCommunication", fallback: "Мобильная связь")
    /// Переименовать счет
    public static let renameAccount = Main.tr("Main", "account.renameAccount", fallback: "Переименовать счет")
  }
  public enum Card {
    /// Реквизиты счета
    public static let accountDetails = Main.tr("Main", "card.accountDetails", fallback: "Реквизиты счета")
    /// Заблокировать карту
    public static let blockCard = Main.tr("Main", "card.blockCard", fallback: "Заблокировать карту")
    /// ЖКХ
    public static let hcs = Main.tr("Main", "card.hcs", fallback: "ЖКХ")
    /// Информация о карте
    public static let informationAboutCard = Main.tr("Main", "card.informationAboutCard", fallback: "Информация о карте")
    /// Интернет
    public static let internet = Main.tr("Main", "card.internet", fallback: "Интернет")
    /// Мобильная связь
    public static let mobileCommunication = Main.tr("Main", "card.mobileCommunication", fallback: "Мобильная связь")
    /// Перевыпустить карту
    public static let reissueCard = Main.tr("Main", "card.reissueCard", fallback: "Перевыпустить карту")
    /// Переименовать карту
    public static let renameCard = Main.tr("Main", "card.renameCard", fallback: "Переименовать карту")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Main {
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
