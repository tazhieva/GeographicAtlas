//
//  AppDelegate.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 13.05.2023.
//
import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configUI()
        registerForPushNotifications()
        schedulePushNotification()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = CountriesListVC()
        let nc = UINavigationController(rootViewController: vc)
        vc.title = "World countries"
        window?.rootViewController = nc
        window?.makeKeyAndVisible()

        return true
    }
    
    func configUI() {
        UINavigationBar.appearance().barStyle = .default
        UINavigationBar.appearance().layer.shadowColor = UIColor.lightGray.cgColor
        UINavigationBar.appearance().backItem?.backButtonDisplayMode = .minimal
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "navbarBack")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "navbarBack")
    }
}

// MARK: - Push Notification

extension AppDelegate: UNUserNotificationCenterDelegate {
    private func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    func schedulePushNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Welcome to My App"
        content.body = "Thank you for using our app!"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "myNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
}
