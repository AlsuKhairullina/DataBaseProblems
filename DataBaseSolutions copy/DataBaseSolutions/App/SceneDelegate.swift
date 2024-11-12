//
//  SceneDelegate.swift
//  DataBaseSolutions
//
//  Created by Alexander Korchak on 13.12.2023.
//

import UIKit
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let navigationViewController = UINavigationController(rootViewController: AuthViewController())
           navigationViewController.navigationBar.backgroundColor = .systemGreen
           let appearance = UINavigationBarAppearance()
           appearance.backgroundColor = .systemGreen
           appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
           UINavigationBar.appearance().scrollEdgeAppearance = appearance

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
    }
}

