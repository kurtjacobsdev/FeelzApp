//
//  SceneDelegate.swift
//  Feelz
//
//  Created by Kurt Jacobs on 2022/10/15.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var appDependencies = AppDependencies()
    private lazy var appCoordinator: AppCoordinator = AppCoordinator(dependencies: appDependencies)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = appCoordinator.tabBarController
        window?.makeKeyAndVisible()
        appCoordinator.setup()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }

}
