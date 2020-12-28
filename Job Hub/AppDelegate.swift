//
//  AppDelegate.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/27/20.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		ThemeService.setTheme(.primary)
		
		let navigationController = UINavigationController(rootViewController: JobListViewController())
		navigationController.setNavigationBarHidden(true, animated: true)
		
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
		
		return true
	}
}
