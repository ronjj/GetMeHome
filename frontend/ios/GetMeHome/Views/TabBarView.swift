//
//  TabBarView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/11/24.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
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
    }
}
