//
//  ContentView.swift
//  twitter-clone
//
//  Created by Torekhan Mukhtarov on 30.03.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        if viewModel.isAuthenticated {
            if let user = viewModel.currentUser {
                MainView(user: user)
            }
        } else {
            WelcomeView()
        }
    }
}

#Preview {
    ContentView()
}
