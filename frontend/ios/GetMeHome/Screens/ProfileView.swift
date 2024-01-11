//
//  ProfileView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/11/24.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel

    var body: some View {
        VStack{
            Text("Profile View")
            Text("You're logged in as \(authViewModel.displayName).")
            Button {
                authViewModel.signOut()
            } label: {
                Text("Sign Out")
            }
        }
    }
}
