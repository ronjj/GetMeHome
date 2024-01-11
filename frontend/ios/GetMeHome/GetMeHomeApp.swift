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
    
    @StateObject private var viewModel = AuthenticationViewModel()
    @State private var presentingLoginScreen = false
    @State private var presentingProfileScreen = false
    
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                
                switch viewModel.authenticationState {
                case .unauthenticated, .authenticating:
                    VStack {
                        ZStack {
                            LinearGradient(gradient: Gradient(colors: [.purple]), startPoint: .leading, endPoint: .trailing)
                            VStack {
                                Text("GetMeHome")
                                      .fontWeight(.black)
                                      .font(.title)
                                      .foregroundStyle(.white)
                                Button("Tap here to log in") {
                                    viewModel.reset()
                                    presentingLoginScreen.toggle()
                                }
                            }
                        }
                        .ignoresSafeArea(edges: .all)
                    }
                    .sheet(isPresented: $presentingLoginScreen) {
                        AuthenticationView()
                            .environmentObject(viewModel)
                    }
                case .authenticated:
                    VStack {
                        ContentView()
                        Text("You're logged in as \(viewModel.displayName).")
                        Button("Tap here to sign out") {
                            viewModel.signOut()
                            //          presentingProfileScreen.toggle()
                        }
                    }
                }
            }
        }
    }
}
