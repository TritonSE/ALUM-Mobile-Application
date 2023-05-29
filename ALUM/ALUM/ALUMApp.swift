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
}

struct RootView: View {
    @ObservedObject var currentUser: CurrentUserModel = CurrentUserModel.shared

    var body: some View {
        if self.currentUser.isLoading {
            LoadingView(text: "RootView")
            .onAppear(perform: {
                Task {
                    await self.currentUser.setForInSessionUser()
                }
            })
        } else if self.currentUser.isLoggedIn == false {
            NavigationView {
                LoginScreen()
            }
        } else {
            AllSessionsPage()
        }
    }
}

@main
struct ALUMApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    WindowGroup {
        RootView()
    }
  }
}
