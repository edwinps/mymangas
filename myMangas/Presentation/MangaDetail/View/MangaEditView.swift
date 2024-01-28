//
//  MangaEditView.swift
//  myMangas
//
//  Created by epena on 14/1/24.
//

import SwiftUI

struct MangaEditView: View {
    @Environment(\.dismiss) var dismiss
//    @ObservedObject var viewModel: MangaEditViewModel
    @State private var isSheetPresented = false
    
    @EnvironmentObject var viewModel: MangaDetailViewModel
    var body: some View {
        if viewModel.loading {
            ZStack {
                ProgressView()
                    .controlSize(.large)
                    .padding(.top, 400)
            }
            .ignoresSafeArea()
        } else {
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
                    if viewModel.manga.volumes != nil {
                        Section {
                            HStack {
                                Button(action: {
                                    isSheetPresented.toggle()
                                    print("Button tapped!")
                                }) {
                                    Text("Select Volumes:")
                                        .foregroundColor(.primary)
                                }
                                Spacer()
                                Image(systemName: "\($viewModel.volumesOwned.count).circle")
                                    .font(.title2)
                            }
                        } header: {
                            Text("You have these volumes")
                        }
                    }
                    Section {
                        TextField("Volumes", text: $viewModel.readingVolume)
                            .keyboardType(.numberPad)
                    } header: {
                        Text("volumes you have read")
                    }
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                if let volumes = viewModel.manga.volumes {
                    let volumesArray = (1...volumes).map { String($0) }
                    MultiSelectPickerView(
                        allItems: volumesArray,
                        selectedItems: $viewModel.volumesOwned)
                    .navigationBarTitle("Select Items")
                }
            }
            .navigationTitle(viewModel.manga.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        var success = true
                        Task {
                          await success = viewModel.postCollection()
                        }
                        if success {
                            dismiss()
                        }
                    } label: {
                        Text("Save")
                    }
                }
        }
        }
    }
}

#Preview {
    NavigationStack {
        MangaEditView()
            .environmentObject(MangaDetailViewModel.test)
    }
}
