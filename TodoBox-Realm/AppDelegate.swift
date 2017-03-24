//
//  AppDelegate.swift
//  TodoBox-Realm
//
//  Created by aney on 2017. 3. 23..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

import SnapKit
import ManualLayout

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.backgroundColor = .white
    window.makeKeyAndVisible()
    
    
    let tasListViewController = TaskListViewController()
    let navigationController = UINavigationController(rootViewController: tasListViewController)
    window.rootViewController = navigationController
    
    self.window = window
    
    return true
  }
  
}

