import UIKit
import Combine
import AppIndependent

// swiftlint:disable:next final_class
open class ViewController: BaseController, Themeable {

    public enum AdditionalState {
        case none
        case loading
        case error(ErrorView.Props)
    }

    private(set) var backgroundStyle: BackgroundStyle?

    private let loadingView = UIView()
    private var errorView: ErrorView?

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self is NavigationBarAlwaysVisible {
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
        if self is NavigationBarAlwaysHidden {
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }
    }

    override open func setup() {
        super.setup()
        subscribeOnThemeChanges()
    }

    open func updateAppearance() {
        if let backgroundStyle {
            view.backgroundColor(backgroundStyle.color)
        }
    }

    open func backgroundStyle(_ style: BackgroundStyle) {
        self.backgroundStyle = style
        updateAppearance()
    }

    open func navigationBarStyle(_ style: NavigationBar.Style) {
        (navigationController?.navigationBar as? NavigationBar)?.style(style)
    }

    public func setAdditionState(_ state: AdditionalState) {
        loadingView.removeFromSuperview()
        errorView?.removeFromSuperview()
        errorView = nil
        errorView = ErrorView()

        switch state {
        case .none:
            break
        case .loading:
            // TODO: Impl
            break
        case .error(let props):
            self.errorView?
                .configured(with: props)
            //self.errorView?.embed(in: view)
            self.errorView?.embed(in: view, useSafeAreaGuide: false)
        }
    }

    public func removeAdditionalState() {
        setAdditionState(.none)
    }

    public func stopErrorAnimation() {
        errorView?.stopAnimation()
    }

    public func changeTabBar(
        hidden:Bool,
        animated: Bool) {
        guard let tabBar = self.tabBarController?.tabBar else { return }
        if tabBar.isHidden == hidden { return }
        let frame = tabBar.frame
        let offset = hidden ? frame.size.height : -frame.size.height
        let duration: TimeInterval = animated ? 0.5 : 0.0
        tabBar.isHidden = false
        UIView.animate(
            withDuration: duration,
            animations: {
            tabBar.frame = frame.offsetBy(dx: 0, dy: offset)
        }, completion: { _ in
            tabBar.isHidden = hidden
        })
    }
}
