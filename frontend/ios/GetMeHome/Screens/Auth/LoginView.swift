//
//  LoginView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/11/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    private func signInWithGoogle() {
        Task {
            if await viewModel.signInWithGoogle() == true {
                dismiss()
            }
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.lightPurple, Color.darkPurple],
                           startPoint: .bottomLeading,
                           endPoint: .topTrailing)
            VStack(spacing: 20) {
                VStack(spacing: 2) {
                    Text("GetMeHome")
                        .fontWeight(.black)
                        .font(.title)
                        .foregroundStyle(.white)
                    Text("Find Trips Home")
                        .fontWeight(.medium)
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
                Button {
                    signInWithGoogle()
                    AnalyticsManager.shared.logEvent(name: "LoginView_GoogleSignInClicked")
                } label: {
                    Text("Sign in with Google")
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background(alignment: .leading) {
                            Image("Google")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .frame(height: 45)
                        }
                }
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .buttonStyle(.bordered)
            }
            .listStyle(.plain)
            .padding()
        }
        .analyticsScreen(name: "LoginView")
        .ignoresSafeArea(edges: .all)
        .onAppear {
            AnalyticsManager.shared.logEvent(name: "LoginView_Appear")
        }
    }
}
