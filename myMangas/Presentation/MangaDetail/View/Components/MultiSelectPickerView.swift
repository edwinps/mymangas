//
//  MultiSelectPickerView.swift
//  myMangas
//
//  Created by epena on 15/1/24.
//

import SwiftUI

struct MultiSelectPickerView: View {
    @State var allItems: [String]
    @Binding var selectedItems: [String]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .symbolVariant(.circle)
                        .symbolVariant(.fill)
                        .font(.largeTitle)
                        .foregroundStyle(.primary)
                }
                .padding([.trailing, .top])
                .buttonStyle(.plain)
                .opacity(0.5)
            }
            
            List {
                ForEach(allItems, id: \.self) { item in
                    Button(action: {
                        withAnimation {
                            if self.selectedItems.contains(item) {
                                self.selectedItems.removeAll(where: { $0 == item })
                            } else {
                                self.selectedItems.append(item)
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "checkmark")
                                .opacity(self.selectedItems.contains(item) ? 1.0 : 0.0)
                            Text(item)
                        }
                    }
                    .foregroundColor(.primary)
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    NavigationStack {
        MultiSelectPickerView(allItems: (1...10).map { String($0) },
                              selectedItems: .constant(["1"]))
    }
}


