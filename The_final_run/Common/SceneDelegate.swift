//
//  SceneDelegate.swift
//  The_final_run
//
//  Created by Maksim Matveichuk on 01.Sep.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        let startViewController = MainMenuViewController.instantiate() as! MainMenuViewController
        navigationController.viewControllers = [startViewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }


}

