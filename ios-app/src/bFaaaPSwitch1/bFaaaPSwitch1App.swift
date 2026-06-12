//
//  bFaaaPSwitch1App.swift
//  bFaaaPSwitch1
//
//  Created by 宍戸知行 on 2020/12/02.
//

import SwiftUI


class AppDelegate: UIResponder, UIApplicationDelegate, UIWindowSceneDelegate {
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UIApplication.shared.isIdleTimerDisabled = true //appを常にオンにする
        
        return true
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    func sceneDidEnterBackground(_ scene: UIScene){
        UIApplication.shared.isIdleTimerDisabled = false
    }
}




@main
struct bFaaaPSwitch1App: App {
    var body: some Scene {
        
        WindowGroup {
            ContentView()
           
            
        }
        
        
        
    }
}
