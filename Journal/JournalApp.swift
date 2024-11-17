//
//  JournalApp.swift
//  Journal
//
//  Created by Cameron Crockett on 11/15/24.
//

import SwiftUI
import FirebaseCore
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


@main
struct JournalApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authModel = AuthModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if authModel.isUserAuthenticated {
                    ContentView()
                        .environmentObject(authModel)
                } else {
                    AuthView()
                        .environmentObject(authModel)
                }
            }
            .animation(.easeInOut, value: authModel.isUserAuthenticated)
        }
    }
}
