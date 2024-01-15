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
            ContentView()
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
        
            ProfileView()
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
            .environmentObject(authViewModel)
            
            SavedTripsView()
            .tabItem {
                    Image(systemName: "bookmark")
                    Text("Saved")
            }
            .navigationTitle("Saved Trips")
        }
    }
}
