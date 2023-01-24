//
//  SBTTestApp.swift
//  SBTTest
//
//  Created by Oliver Foggin on 24/01/2023.
//

import SwiftUI
import SBTUITestTunnelServer

final class AppDelegate: UIResponder, UIApplicationDelegate {

	var title: String!

	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
	) -> Bool {
		// This has to be defined here in order to not crash the app
		// The takeOff code seems to hop past the rest of the didFinishLaunching
		// and jump straight into the body of the app.
		// Which uses the implicitly unwrapped property and crashes the tests.
		title = "Welcome to the app!"

#if DEBUG
		SBTUITestTunnelServer.takeOff()
#endif

		// Uncomment this line and comment the top one.
		// This will cause the tests to crash
//		title = "Welcome to the app!"

		return true
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
	}

	func application(
		_ application: UIApplication,
		didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
	) {

	}

	func application(
		_ application: UIApplication,
		didFailToRegisterForRemoteNotificationsWithError error: Error
	) {
	}
}

@main
struct SBTTestApp: App {
	@UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

	var body: some Scene {
		WindowGroup {
			ContentView(viewModel: .init(title: appDelegate.title))
		}
	}
}
