//
//  TabBarView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/11/24.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        TabView {
            NavigationStack {
                ContentView()
            }

            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            
            SavedTripsView()
            .tabItem {
                    Image(systemName: "bookmark")
                    Text("Saved")
            }
            
            BoughtTicketsView()
            .tabItem {
                    Image(systemName: "ticket")
                    Text("Tickets")
            }
            
//            TrackedTripsView()
//            .tabItem {
//                Image(systemName: "bell")
//                Text("Tracking")
//            }
            
            ProfileView()
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
            .environmentObject(authViewModel)
        }
        
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
