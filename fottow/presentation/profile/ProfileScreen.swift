//
//  ProfileScreen.swift
//  fottow
//
//  Created by Rober on 16/9/25.
//

import SwiftUI

struct ProfileScreen: View {
    @State private var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: viewModel.user?.profileImage ?? "")){ phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 200, height: 200)
                        .background(Color.gray.opacity(0.2))
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                case .failure:
                    ProgressView()
                        .frame(width: 200, height: 200)
                        .background(Color.gray.opacity(0.2))
                @unknown default:
                    EmptyView()
                }
            }
            
            Text(viewModel.user?.nick ?? "")
                .font(.title)
                .bold()
            
            Text(viewModel.user?.userName ?? "")
                .font(.title)
                .bold()
        }
        .onAppear() {
            viewModel.getUser()
        }
        .navigationBarTitle("Galería")
    }
}

#Preview {
    ProfileScreen()
}
