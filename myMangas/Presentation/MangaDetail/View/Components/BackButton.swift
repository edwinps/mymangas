//
//  BackButton.swift
//  myMangas
//
//  Created by epena on 31/1/24.
//

import SwiftUI

struct backButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(action: { dismiss() }, label: {
            HStack() {
                Image(systemName: "arrow.left")
                    .imageScale(.large)
                    .foregroundColor(.primary)
                    .padding(5)
                    .background(Color.primary.colorInvert())
                    .clipShape(Circle())
                Spacer()
            }
        })
        
    }
}

#Preview {
    backButton()
}
