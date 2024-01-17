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
            NavigationStack {
                SavedTripsView()
            }
           
            .tabItem {
                    Image(systemName: "bookmark")
                    Text("Saved")
            }
            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
            .environmentObject(authViewModel)
        }
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.stackedLayoutAppearance.normal.iconColor = .gray
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
            if colorScheme == .light {
                appearance.stackedLayoutAppearance.selected.iconColor = .black
                appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(Color.black)]
            } else {
                appearance.stackedLayoutAppearance.selected.iconColor = .white
                appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(Color.white)]
            }
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
