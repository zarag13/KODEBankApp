// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Asset {
  public enum BigBankCard {
    public static let debit = ImageAsset(name: "BigBankCard/Debit")
  }
  public enum BigIlustration {
    public static let faceId = ImageAsset(name: "BigIlustration/faceId")
    public static let handshake = ImageAsset(name: "BigIlustration/handshake")
    public static let notData = ImageAsset(name: "BigIlustration/notData")
    public static let notServer = ImageAsset(name: "BigIlustration/notServer")
    public static let notWifi = ImageAsset(name: "BigIlustration/notWifi")
    public static let pinCode = ImageAsset(name: "BigIlustration/pinCode")
    public static let touchId = ImageAsset(name: "BigIlustration/touchId")
    public static let update = ImageAsset(name: "BigIlustration/update")
  }
  public static let bitmap = ImageAsset(name: "Bitmap")
  public enum Icon24px {
    public static let gibdd = ImageAsset(name: "Icon24px/GIBDD")
    public static let internet = ImageAsset(name: "Icon24px/Internet")
    public static let jkh = ImageAsset(name: "Icon24px/JKH")
    public static let accountIn = ImageAsset(name: "Icon24px/accountIn")
    public static let accountOut = ImageAsset(name: "Icon24px/accountOut")
    public static let accountPay = ImageAsset(name: "Icon24px/accountPay")
    public static let accountToAccount = ImageAsset(name: "Icon24px/accountToAccount")
    public static let addPlus = ImageAsset(name: "Icon24px/addPlus")
    public static let arrowSwipe = ImageAsset(name: "Icon24px/arrowSwipe")
    public static let back = ImageAsset(name: "Icon24px/back")
    public static let bank = ImageAsset(name: "Icon24px/bank")
    public static let bankAccount = ImageAsset(name: "Icon24px/bankAccount")
    public static let bankomat = ImageAsset(name: "Icon24px/bankomat")
    public static let camera = ImageAsset(name: "Icon24px/camera")
    public static let cancel = ImageAsset(name: "Icon24px/cancel")
    public static let card = ImageAsset(name: "Icon24px/card")
    public static let cardOut = ImageAsset(name: "Icon24px/cardOut")
    public static let cardPay = ImageAsset(name: "Icon24px/cardPay")
    public static let cardWhite = ImageAsset(name: "Icon24px/cardWhite")
    public static let `case` = ImageAsset(name: "Icon24px/case")
    public static let check = ImageAsset(name: "Icon24px/check")
    public static let checkOff = ImageAsset(name: "Icon24px/checkOff")
    public static let checkOn = ImageAsset(name: "Icon24px/checkOn")
    public static let chevronDown = ImageAsset(name: "Icon24px/chevronDown")
    public static let chevronRight = ImageAsset(name: "Icon24px/chevronRight")
    public static let chevronUp = ImageAsset(name: "Icon24px/chevronUp")
    public static let close = ImageAsset(name: "Icon24px/close")
    public static let contacts = ImageAsset(name: "Icon24px/contacts")
    public static let delete = ImageAsset(name: "Icon24px/delete")
    public static let doll = ImageAsset(name: "Icon24px/doll")
    public static let edit = ImageAsset(name: "Icon24px/edit")
    public static let eur = ImageAsset(name: "Icon24px/eur")
    public static let exchangeRates = ImageAsset(name: "Icon24px/exchange_rates")
    public static let eye = ImageAsset(name: "Icon24px/eye")
    public static let eyeOff = ImageAsset(name: "Icon24px/eyeOff")
    public static let fee = ImageAsset(name: "Icon24px/fee")
    public static let filter = ImageAsset(name: "Icon24px/filter")
    public static let filterBadge = ImageAsset(name: "Icon24px/filterBadge")
    public static let fingerprint = ImageAsset(name: "Icon24px/fingerprint")
    public static let headerShareIcon = ImageAsset(name: "Icon24px/headerShareIcon")
    public static let headphone = ImageAsset(name: "Icon24px/headphone")
    public static let history = ImageAsset(name: "Icon24px/history")
    public static let hold = ImageAsset(name: "Icon24px/hold")
    public static let info = ImageAsset(name: "Icon24px/info")
    public static let input = ImageAsset(name: "Icon24px/input")
    public static let loader = ImageAsset(name: "Icon24px/loader")
    public static let lock = ImageAsset(name: "Icon24px/lock")
    public static let lockWhite = ImageAsset(name: "Icon24px/lockWhite")
    public static let mail = ImageAsset(name: "Icon24px/mail")
    public static let mainProduct = ImageAsset(name: "Icon24px/mainProduct")
    public static let marker = ImageAsset(name: "Icon24px/marker")
    public static let message = ImageAsset(name: "Icon24px/message")
    public static let mobile = ImageAsset(name: "Icon24px/mobile")
    public static let mobilePay = ImageAsset(name: "Icon24px/mobilePay")
    public static let moonStars = ImageAsset(name: "Icon24px/moonStars")
    public static let next = ImageAsset(name: "Icon24px/next")
    public static let nfc = ImageAsset(name: "Icon24px/nfc")
    public static let other = ImageAsset(name: "Icon24px/other")
    public static let payPass = ImageAsset(name: "Icon24px/payPass")
    public static let payment = ImageAsset(name: "Icon24px/payment")
    public static let pdf = ImageAsset(name: "Icon24px/pdf")
    public static let phone = ImageAsset(name: "Icon24px/phone")
    public static let phoneCall = ImageAsset(name: "Icon24px/phoneCall")
    public static let phoneGreen = ImageAsset(name: "Icon24px/phoneGreen")
    public static let photo = ImageAsset(name: "Icon24px/photo")
    public static let question = ImageAsset(name: "Icon24px/question")
    public static let radioOff = ImageAsset(name: "Icon24px/radioOff")
    public static let radioOn = ImageAsset(name: "Icon24px/radioOn")
    public static let recoverPassword = ImageAsset(name: "Icon24px/recoverPassword")
    public static let refresh = ImageAsset(name: "Icon24px/refresh")
    public static let rename = ImageAsset(name: "Icon24px/rename")
    public static let repay = ImageAsset(name: "Icon24px/repay")
    public static let requisites = ImageAsset(name: "Icon24px/requisites")
    public static let reverse = ImageAsset(name: "Icon24px/reverse")
    public static let route = ImageAsset(name: "Icon24px/route")
    public static let rubs = ImageAsset(name: "Icon24px/rubs")
    public static let search = ImageAsset(name: "Icon24px/search")
    public static let settings = ImageAsset(name: "Icon24px/settings")
    public static let share = ImageAsset(name: "Icon24px/share")
    public static let shopping = ImageAsset(name: "Icon24px/shopping")
    public static let star = ImageAsset(name: "Icon24px/star")
    public static let starCircle = ImageAsset(name: "Icon24px/starCircle")
    public static let taxes = ImageAsset(name: "Icon24px/taxes")
    public static let touch = ImageAsset(name: "Icon24px/touch")
    public static let trash = ImageAsset(name: "Icon24px/trash")
    public static let user = ImageAsset(name: "Icon24px/user")
    public static let userCircle = ImageAsset(name: "Icon24px/userCircle")
  }
  public enum Icon40px {
    public static let acado = ImageAsset(name: "Icon40px/Acado")
    public static let golden = ImageAsset(name: "Icon40px/Golden")
    public static let mts = ImageAsset(name: "Icon40px/MTS")
    public static let masterCard32 = ImageAsset(name: "Icon40px/MasterCard32")
    public static let pochtaBank = ImageAsset(name: "Icon40px/PochtaBank")
    public static let tinkoff = ImageAsset(name: "Icon40px/Tinkoff")
    public static let account = ImageAsset(name: "Icon40px/account")
    public static let add = ImageAsset(name: "Icon40px/add")
    public static let alternativa = ImageAsset(name: "Icon40px/alternativa")
    public static let beeline = ImageAsset(name: "Icon40px/beeline")
    public static let bind = ImageAsset(name: "Icon40px/bind")
    public static let energo = ImageAsset(name: "Icon40px/energo")
    public static let gaz = ImageAsset(name: "Icon40px/gaz")
    public static let icEur = ImageAsset(name: "Icon40px/ic_eur")
    public static let icUsd = ImageAsset(name: "Icon40px/ic_usd")
    public static let kode = ImageAsset(name: "Icon40px/kode")
    public static let mediumIcon = ImageAsset(name: "Icon40px/medium icon")
    public static let megafon = ImageAsset(name: "Icon40px/megafon")
    public static let off = ImageAsset(name: "Icon40px/off")
    public static let on = ImageAsset(name: "Icon40px/on")
    public static let rostelecom = ImageAsset(name: "Icon40px/rostelecom")
    public static let rub = ImageAsset(name: "Icon40px/rub")
    public static let tele2 = ImageAsset(name: "Icon40px/tele2")
    public static let vodokanal = ImageAsset(name: "Icon40px/vodokanal")
    public static let whiteMe = ImageAsset(name: "Icon40px/white_me")
    public static let whiteMinus = ImageAsset(name: "Icon40px/white_minus")
    public static let whitePlus = ImageAsset(name: "Icon40px/white_plus")
    public static let yantar = ImageAsset(name: "Icon40px/yantar")
    public static let yota = ImageAsset(name: "Icon40px/yota")
  }
  public static let logoL = ImageAsset(name: "LogoL")
  public static let logoM = ImageAsset(name: "LogoM")
  public static let logoS = ImageAsset(name: "LogoS")
  public enum SmallIcon {
    public static let messages = ImageAsset(name: "SmallIcon/Messages")
    public static let notificationBadge = ImageAsset(name: "SmallIcon/Notification Badge")
    public static let property1Normal = ImageAsset(name: "SmallIcon/Property 1=Normal")
    public static let property1Modle = ImageAsset(name: "SmallIcon/Property 1=modle")
    public static let property1Small = ImageAsset(name: "SmallIcon/Property 1=small")
    public static let masterCard = ImageAsset(name: "SmallIcon/masterCard")
    public static let visa = ImageAsset(name: "SmallIcon/visa")
    public static let whitePlusDots = ImageAsset(name: "SmallIcon/white_plus dots")
  }
  public enum MiniBankCard {
    public static let bankCard = ImageAsset(name: "miniBankCard/bankCard")
    public static let raiffaizen = ImageAsset(name: "miniBankCard/raiffaizen")
    public static let sberbank = ImageAsset(name: "miniBankCard/sberbank")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public struct ImageAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  public var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  public func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

public extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

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
