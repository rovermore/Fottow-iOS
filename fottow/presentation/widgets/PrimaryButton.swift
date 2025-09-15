//
//  PrimaryButton.swift
//  fottow
//
//  Created by Rober on 15/9/25.
//

import SwiftUI

struct PrimaryButton: View {
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text(text)
                .frame(maxWidth: .infinity, minHeight: 40)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(4)
                .fontWeight(.bold)
                
        })
    }
}

struct SecondaryButton: View {
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text(text)
                .frame(maxWidth: .infinity, minHeight: 50)
                .fontWeight(.bold)
        })
    }
}

#Preview {
    VStack(spacing: 16) {
        PrimaryButton(text: "Primary Button") {}
        SecondaryButton(text: "Secondary Button") {}
    }
    .padding()
}
