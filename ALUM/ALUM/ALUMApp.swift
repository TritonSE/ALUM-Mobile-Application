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

extension View {
    func dismissKeyboardOnDrag() -> some View {
        self.gesture(DragGesture().onChanged { gesture in
            guard gesture.translation.height > 0 else { return }
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        })
    }
}

@main
struct ALUMApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


  var body: some Scene {
    WindowGroup {
        RootRouter()
    }
  }
}
