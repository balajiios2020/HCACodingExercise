//
//  SceneDelegate.swift
//  HCACodingExercise
//
//  Created by Balaji Peddaiahgari on 11/22/20.
//  Copyright © 2020 Balaji Peddaiahgari. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		if let windowScene = scene as? UIWindowScene {
			let window = UIWindow(windowScene: windowScene)
			window.rootViewController = UINavigationController(rootViewController: ViewController())
			self.window = window
			window.makeKeyAndVisible()
		}
	}

}

