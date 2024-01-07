//
//  FilterView.swift
//  myMangas
//
//  Created by epena on 5/1/24.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject var viewModel: MangaListViewModel
    @Binding var isPresented: Bool
    
    var body: some View {
        ScrollView {
            if !viewModel.demographics.isEmpty {
                FilterDropDown(title: "Demographics",
                               options: viewModel.demographics,
                               selectedOption: $viewModel.selectedDemographic)
            }
            if !viewModel.genres.isEmpty {
                FilterDropDown(title: "Genres",
                               options: viewModel.genres,
                               selectedOption: $viewModel.selectedGenre)
            }
            if !viewModel.themes.isEmpty {
                FilterDropDown(title: "Themes",
                               options: viewModel.themes,
                               selectedOption: $viewModel.selectedTheme)
            }
            HStack {
                Spacer()
                Button("Clean filters") {
                    viewModel.clearFilters()
                }
                Button("Apply") {
                    Task {
                        await viewModel.applyFilters()
                    }
                    isPresented.toggle()
                }
                .padding()
            }
        }
        .padding(20)
        .navigationTitle("Filters")
    }
}

struct FilterDropDown: View {
    let title: String
    let options: [String]
    @Binding var selectedOption: String?

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 4)

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 8) {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        if selectedOption == option {
                            selectedOption = nil
                        } else {
                            selectedOption = option
                        }
                    }) {
                        Text(option)
                            .fixedSize()
                            .foregroundColor(selectedOption == option ? .accentColor : .primary)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.secondary.opacity(selectedOption == option ? 0.2 : 0))
                            )
                    }
                }
            }
        }.padding(.bottom, 20)
    }
}

#Preview {
    FilterView(isPresented: .constant(true))
        .environmentObject(MangaListViewModel.test)
}
