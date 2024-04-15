//
//  SplashScreenView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/13/24.
//

import SwiftUI

struct SplashScreenView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            NavigationStack {
//                Removed Signing in for now since there is no extra functonality
//                switch viewModel.authenticationState {
//                case .unauthenticated, .authenticating:
//                    AuthenticationView()
//                        .environmentObject(viewModel)
//                case .authenticated:
                    TabBarView()
                        .environmentObject(viewModel)

//                }
            }
        } else {
            ZStack {
                LinearGradient(colors: [Color.lightPurple, Color.darkPurple],
                               startPoint: .bottomLeading,
                               endPoint: .topTrailing)
                VStack {
                    VStack {
                        Image("icon_transparent")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 250, height: 250)
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.75)) {
                            self.size = 0.9
                            self.opacity = 1.00
                        }
                    }
                }
            }
            .ignoresSafeArea(.all)
            .analyticsScreen(name: "SplashScreen")
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
                AnalyticsManager.shared.logEvent(name: "SplashScreen_Appear")
            }
        }
    }
}
