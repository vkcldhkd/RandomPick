//
//  SceneDelegate.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/3/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        
        // Data Layer
        let repository = RandomUserRepositoryImpl()
        
        // Domain Layer
        let useCase = DefaultFetchProfilesUseCase(repository: repository)
        
        // View Layer
        let viewController = LottoSpotlightCircleViewController(fetchProfilesUseCase: useCase)
        
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
    }
}
