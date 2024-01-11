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
                    AuthenticationView()
                        .environmentObject(viewModel)
                case .authenticated:
                    VStack {
                        TabBarView()
                            .environmentObject(viewModel)
                        
                    }
                }
            }
        }
    }
}

struct TabBarView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "house")
                    Text("House")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .environmentObject(authViewModel)
        }
    }
}
