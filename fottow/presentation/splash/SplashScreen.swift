//
//  SplashScreen.swift
//  fottow
//
//  Created by Rober on 16/9/25.
//

import SwiftUI

struct SplashScreen: View {
    @State private var viewModel = SplashViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Fottow")
                    .font(.system(size: 44, weight: .bold, design: .default))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .fullScreenCover(isPresented: .constant(viewModel.appState == .loggedIn || viewModel.appState == .loggedOut)) {
                        switch viewModel.appState {
                        case .loggedIn:
                            MainTabScreen()
                        case .loggedOut:
                            LoginScreen()
                        }
                    }
        }
    }
}

#Preview {
    SplashScreen()
}
