//
//  GetMeHomeApp.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/23/23.
//



import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct GetMeHomeApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        AuthenticatedView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.purple]), startPoint: .leading, endPoint: .trailing)
                Text("GetMeHome")
                      .fontWeight(.black)
                      .font(.title)
                      .foregroundStyle(.white)
            }
            .ignoresSafeArea(edges: .all)
        
        } content: {
          ContentView()
        Spacer()

        }
        .ignoresSafeArea(edges: .all)
      }
    }
  }
}
