//
//  MangaEditView.swift
//  myMangas
//
//  Created by epena on 14/1/24.
//

import SwiftUI

struct MangaEditView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: MangaEditViewModel
    
    var body: some View {
        VStack {
            AsyncImage(url: viewModel.manga.mainPicture) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 200, maxHeight: 300)
                    .cornerRadius(5)
                    .shadow(color: .black.opacity(0.7), radius: 5, x: 0, y: 5)
            } placeholder: { }
            Spacer()
            Form {
                Section {
                    Toggle("Completed?", isOn: $viewModel.isCompleted)
                } header: {
                    Text("you have the collections")
                }
                if let volumes = viewModel.manga.volumes {
                    Section {
                        HStack {
                            Picker("Volumes", selection: $viewModel.selectedVolumes) {
                                ForEach(1...volumes, id: \.self) { volume in
                                    Text("\(volume)")
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                    } header: {
                        Text("You have these volumes")
                    }
                }
                Section {
                    TextField("Volumes", text: $viewModel.quantity)
                        .keyboardType(.numberPad)
                } header: {
                    Text("volumes you have read")
                }
            }
        }
        .navigationTitle(viewModel.manga.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    dismiss()
                } label: {
                    Text("Save")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MangaEditView(viewModel: .test)
    }
}
