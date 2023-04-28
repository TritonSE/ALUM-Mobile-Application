//
//  ALUMApp.swift
//  ALUM
//
//  Created by Aman Aggarwal on 1/12/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
      FirebaseApp.configure()
      
      return true
  }

 func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Check if the URL scheme is your custom scheme
        if url.scheme == "alumapp" {
            print("Doing something with uri")
            print(url)
            return true
        }
        
        print("Not doing anything")
        return false
    }
}

@main
struct ALUMApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    WindowGroup {
        
    
        
        
        
        //SignUpPageView()
         CalendlyBooking()
    }
  }
}
