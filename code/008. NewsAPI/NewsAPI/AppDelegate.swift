//
//  AppDelegate.swift
//  NewsAPI
//
//  Created by iOS Dev Log on 2018/3/1.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.barTintColor = #colorLiteral(red: 0.3607843137, green: 0.7803921569, blue: 0.6980392157, alpha: 1)
        navigationBarAppearance.tintColor = .white
        navigationBarAppearance.barStyle = .black
        
        return true
    }
}

