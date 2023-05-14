//
//  AppDelegate.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 13.05.2023.
//
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        
        configUI()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        let vc = CountriesListVC()
        let nc = UINavigationController(rootViewController: vc)
        vc.title = "World countries"
        window?.rootViewController = nc
    
        return true
    }
    
    func configUI() {
        UINavigationBar.appearance().frame.size.height = 44 // Replace 44 with the desired height
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().barStyle = .default
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "navbarBack")?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0))
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "navbarBack")
    }

}
