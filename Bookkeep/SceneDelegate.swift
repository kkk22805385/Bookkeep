//
//  SceneDelegate.swift
//  Bookkeep
//
//  Created by aa on 2020/9/11.
//  Copyright © 2020 Bookkeep. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let mainVC = MainViewController(nibName: "MainViewController", bundle: nil)
        let statVC = StatisticsViewController(nibName: "StatisticsViewController", bundle: nil)
        let moreVC = MoreViewController(nibName: "MoreViewController", bundle: nil)
        
        let tbc = UITabBarController.init()
        
        mainVC.tabBarItem.title = "日曆"
        mainVC.tabBarItem.image = UIImage.init(systemName: "doc.text.fill")
        statVC.tabBarItem.title = "統計"
        statVC.tabBarItem.image = UIImage.init(systemName: "dollarsign.square.fill")
        moreVC.tabBarItem.title = "更多"
        moreVC.tabBarItem.image = UIImage.init(systemName: "square.grid.2x2.fill")
        
        tbc.viewControllers = [mainVC,statVC,moreVC]
        
        tbc.tabBarItem.badgeColor = UIColor.init(hexFromString: "#707070")
        tbc.tabBar.tintColor = UIColor.init(hexFromString: "#008880")
        tbc.tabBar.barTintColor = .white
        
        mainVC.tabBarHeight = CGFloat(tbc.tabBar.bounds.height)
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = tbc //navController
        window?.makeKeyAndVisible()
        
       
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

