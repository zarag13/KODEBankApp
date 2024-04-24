import UI
import Core
import UIKit
import Services
import Swinject
import SwinjectAutoregistration

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        let appWindow = Window(frame: windowScene.coordinateSpace.bounds)
        appWindow.windowScene = windowScene

        let userActivity = connectionOptions.userActivities.first
        setup(window: appWindow, userActivity: userActivity)
    }

    private func setup(window: UIWindow, userActivity: NSUserActivity?) {
        let diContainer = DIContainer.shared

        diContainer.assemble(assembly: StartUpAssembly())

        appCoordinator = diContainer.resolver ~> (AppCoordinator.self, argument: window)
        appCoordinator?.start()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}

    func scene(
        _ scene: UIScene,
        continue userActivity: NSUserActivity
    ) {
    }

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        true
    }
}
