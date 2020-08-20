//
//  AppDelegate.swift
//  FourSquare-ios
//
//  Created by mohammad on 8/19/20.
//  Copyright © 2020 mohammad. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // MARK: - network Manager
    lazy var networkManager = NetworkManagerFactory().createNetworkManager()
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FourSquare_ios")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        })
        return container
    }()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let frame = UIScreen.main.bounds
        self.window = UIWindow(frame: frame)
        self.window?.rootViewController = setInitialization()
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

// ===============
// MARK: - Methods
// ===============
extension AppDelegate {
    class func getInstance() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate // swiftlint:disable:this force_cast
    }
    
    func setInitialization() -> UIViewController {
        let dc = HomeDependencyContainer()
        let homeVC = dc.makeHomeViewController()
        let navVc = CustomNavigationController(rootViewController: homeVC)
        return navVc
    }
}
