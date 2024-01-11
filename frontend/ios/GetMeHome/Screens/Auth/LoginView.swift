//
//  LoginView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/11/24.
//

import SwiftUI
import Combine
import FirebaseAnalyticsSwift

private enum FocusableField: Hashable {
    case email
    case password
}

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var focus: FocusableField?
    
    private func signInWithEmailPassword() {
        Task {
            if await viewModel.signInWithEmailPassword() == true {
                dismiss()
            }
        }
    }
    
    private func signInWithGoogle() {
        Task {
            if await viewModel.signInWithGoogle() == true {
                dismiss()
            }
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple]), startPoint: .leading, endPoint: .trailing)
            VStack {
                Text("GetMeHome")
                    .fontWeight(.black)
                    .font(.title)
                    .foregroundStyle(.white)
                
                Button(action: signInWithGoogle) {
                    Text("Sign in with Google")
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background(alignment: .leading) {
                            Image("Google")
                                .frame(width: 30, alignment: .center)
                        }
                }
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .buttonStyle(.bordered)

                
            }
            .listStyle(.plain)
            .padding()
            //    .analyticsScreen(name: "\(Self.self)")
        }
        .ignoresSafeArea(edges: .all)
    }
}
