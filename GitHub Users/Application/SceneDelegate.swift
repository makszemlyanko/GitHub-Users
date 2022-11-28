//
//  SceneDelegate.swift
//  GitHub Users
//
//  Created by Maks Kokos on 18.11.2022.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let rootViewController = UsersListViewController()
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.navigationBar.standardAppearance = createNavBarAppearance()
        navController.navigationBar.scrollEdgeAppearance = navController.navigationBar.standardAppearance
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    private func createNavBarAppearance() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .backgroundDarkGray
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.accentGreen]
        return appearance
    }
}
