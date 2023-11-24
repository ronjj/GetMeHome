//
//  ContentView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/23/23.
//

import SwiftUI

struct Trip: Hashable {
    let date: String
    let price: Float
}

struct ContentView: View {
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Text("Hello, world!")
            }
        }
        .padding()
        .navigationTitle("GetMeHome")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
