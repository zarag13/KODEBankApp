// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Common {
  /// Все
  public static let all = Common.tr("Common", "all", fallback: "Все")
  /// Разрешить
  public static let allow = Common.tr("Common", "allow", fallback: "Разрешить")
  /// Применить
  public static let apply = Common.tr("Common", "apply", fallback: "Применить")
  /// Внимание
  public static let attention = Common.tr("Common", "attention", fallback: "Внимание")
  /// Отменить
  public static let cancel = Common.tr("Common", "cancel", fallback: "Отменить")
  /// Изменить
  public static let change = Common.tr("Common", "change", fallback: "Изменить")
  /// Закрыть
  public static let close = Common.tr("Common", "close", fallback: "Закрыть")
  /// Продолжить
  public static let `continue` = Common.tr("Common", "continue", fallback: "Продолжить")
  /// Удалить
  public static let delete = Common.tr("Common", "delete", fallback: "Удалить")
  /// Готово
  public static let done = Common.tr("Common", "done", fallback: "Готово")
  /// Откуда
  public static let from = Common.tr("Common", "from", fallback: "Откуда")
  /// Нет
  public static let no = Common.tr("Common", "no", fallback: "Нет")
  /// Ок
  public static let ok = Common.tr("Common", "ok", fallback: "Ок")
  /// Выйти
  public static let quit = Common.tr("Common", "quit", fallback: "Выйти")
  /// Обновить
  public static let refresh = Common.tr("Common", "refresh", fallback: "Обновить")
  /// Повторить
  public static let `repeat` = Common.tr("Common", "repeat", fallback: "Повторить")
  /// Требуется обновление
  public static let requiredUpdate = Common.tr("Common", "requiredUpdate", fallback: "Требуется обновление")
  /// Настройки
  public static let settings = Common.tr("Common", "settings", fallback: "Настройки")
  /// Пропустить
  public static let skip = Common.tr("Common", "skip", fallback: "Пропустить")
  /// Куда
  public static let to = Common.tr("Common", "to", fallback: "Куда")
  /// Да
  public static let yes = Common.tr("Common", "yes", fallback: "Да")
  public enum Error {
    /// Не удалось загрузить данные
    public static let dataRequestFailMessage = Common.tr("Common", "error.dataRequestFailMessage", fallback: "Не удалось загрузить данные")
    /// Что-то пошло не так
    public static let defaultMessage = Common.tr("Common", "error.defaultMessage", fallback: "Что-то пошло не так")
    /// К сожалению, что-то пошло не так
    public static let defaultMessagePity = Common.tr("Common", "error.defaultMessagePity", fallback: "К сожалению, что-то пошло не так")
    /// Ошибка
    public static let defaultTitle = Common.tr("Common", "error.defaultTitle", fallback: "Ошибка")
    /// Заполните поле
    public static let emptyField = Common.tr("Common", "error.emptyField", fallback: "Заполните поле")
    /// На сервере проводятся технические работы. Приложение будет доступно после 15:00 МСК
    public static let engineringWorks = Common.tr("Common", "error.engineringWorks", fallback: "На сервере проводятся технические работы. Приложение будет доступно после 15:00 МСК")
    /// Неверный формат
    public static let invalidFieldInput = Common.tr("Common", "error.invalidFieldInput", fallback: "Неверный формат")
    /// Ошибка загрузки данных
    public static let loadingErrorMessage = Common.tr("Common", "error.loadingErrorMessage", fallback: "Ошибка загрузки данных")
    /// Не удалось загрузить данные
    public static let loadingFailedMessage = Common.tr("Common", "error.loadingFailedMessage", fallback: "Не удалось загрузить данные")
    /// Проверьте подключение к интернету
    public static let noConnectionMessage = Common.tr("Common", "error.noConnectionMessage", fallback: "Проверьте подключение к интернету")
    /// Нет соединения
    public static let noConnectionTitle = Common.tr("Common", "error.noConnectionTitle", fallback: "Нет соединения")
    /// Вероятно, соединение с Интернетом прервано
    public static let noInternet = Common.tr("Common", "error.noInternet", fallback: "Вероятно, соединение с Интернетом прервано")
    /// Повторите попытку или вернитесь позднее
    public static let repeatMessage = Common.tr("Common", "error.repeatMessage", fallback: "Повторите попытку или вернитесь позднее")
    /// Сервер временно недоступен. Пожалуйста, повторите попытку позднее
    public static let serverNotFound = Common.tr("Common", "error.serverNotFound", fallback: "Сервер временно недоступен. Пожалуйста, повторите попытку позднее")
    /// Включить интернет
    public static let turnInternet = Common.tr("Common", "error.turnInternet", fallback: "Включить интернет")
    /// Для дальнейшего использования приложения требуется установка обновлений
    public static let updateRequired = Common.tr("Common", "error.updateRequired", fallback: "Для дальнейшего использования приложения требуется установка обновлений")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Common {
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
