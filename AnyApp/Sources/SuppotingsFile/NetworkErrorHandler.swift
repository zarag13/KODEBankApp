import UI
import Core
import UIKit
import Network
import AppIndependent

// swiftlint:disable:next final_class
class NetworkErrorHandler {
    // MARK: - Private Properties
    private var monitor: NWPathMonitor?

    // MARK: - Public Methods
    public func errorHandle(_ error: ErrorWithContext, onTap: @escaping (VoidHandler), closeTap: VoidHandler? = nil) -> ErrorView.Props {
        switch error.appError.kind {
        case .timeout:
            return .init(title: Common.attention, message: Common.Error.noInternet, image: Asset.BigIlustration.notWifi.image, buttonTitle: Common.repeat, onTap: onTap, closeTap: closeTap)
        case .serverSendWrongData:
            return .init(title: Common.attention, message: Common.Error.serverNotFound, image: Asset.BigIlustration.notData.image, buttonTitle: Common.repeat, onTap: onTap, closeTap: closeTap)
        default:
            return .init(title: Common.attention, message: Common.Error.engineringWorks, image: Asset.BigIlustration.notData.image, buttonTitle: Common.repeat, onTap: onTap, closeTap: closeTap)
        }
    }

    public func checkInternet(
        returnAlert: @escaping ((UIAlertController) -> Void),
        returnIsOn: @escaping (() -> Void)) {

        monitor = NWPathMonitor()
        self.monitor?.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                returnIsOn()
            } else {
                let alert = UIAlertController(title: Common.Error.turnInternet, message: nil, preferredStyle: .alert)
                let closeAction = UIAlertAction(title: Common.close, style: .destructive, handler: nil)
                let settingsAction = UIAlertAction(title: Common.settings, style: .default) { _ in
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                alert.addAction(closeAction)
                alert.addAction(settingsAction)
                returnAlert(alert)
            }
            self.monitor?.cancel()
            self.monitor = nil
        }
        self.monitor?.start(queue: .main)
    }
}
