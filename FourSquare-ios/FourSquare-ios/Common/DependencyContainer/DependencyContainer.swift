//
//  DependencyContainer.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation

public class DependencyContainer {
    lazy var networkManager: NetworkManagerProtocol = AppDelegate.getInstance().networkManager
    lazy var windowManager = WindowManager(window: AppDelegate.getInstance().window)
    lazy var persistentContainer = AppDelegate.getInstance().persistentContainer.viewContext
}
