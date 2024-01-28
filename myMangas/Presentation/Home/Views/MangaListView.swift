//
//  MangaListView.swift
//  myMangas
//
//  Created by epena on 2/1/24.
//

import SwiftUI

struct MangaListView: View {
    @EnvironmentObject var viewModel: MangaListViewModel
    @State private var showFilterSheet = false
    @State private var searchText: String = ""
    
    var body: some View {
        if viewModel.loading {
            ZStack {
                ProgressView()
                    .controlSize(.large)
                    .padding(.top, 400)
            }
            .ignoresSafeArea()
        } else {
            NavigationStack {
                ScrollView {
                    if !viewModel.filteredBestMangas.isEmpty {
                        BestMangaListView(bestMangas: viewModel.filteredBestMangas)
                            .frame(height: UIScreen.main.bounds.height / 3)
                    }
                    
                    MangaListViewGrid()
                        .padding()
                }
                .navigationBarHidden(false)
                .navigationBarItems(trailing: Button("Filters") {
                    showFilterSheet.toggle()
                })
                .navigationDestination(for: Manga.self) { manga in
                    MangaDetailView(viewModel: MangaDetailViewModel(manga: manga))
                }
                .searchable(text: $searchText)
                .onChange(of: searchText) { _, newSearchText in
                    if !newSearchText.isEmpty {
                        viewModel.performSearch(query: newSearchText)
                    }
                }
                .sheet(isPresented: $showFilterSheet) {
                    FilterView(isPresented: $showFilterSheet)
                }
                .alert("Error",
                       isPresented: $viewModel.showAlert) { } message: {
                    Text(viewModel.msg)
                }
            }
        }
    }
}

private extension MangaListView {
    struct MangaListViewGrid: View {
        @EnvironmentObject var viewModel: MangaListViewModel
        @State private var isLoadingNextPage = false
        var body: some View {
            
            VStack(alignment: .leading) {
                Text("Mangas")
                    .font(.title)
                    .foregroundColor(.primary)
                    .bold()
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
                    ForEach(viewModel.mangas) { manga in
                        NavigationLink(value: manga) {
                            MangaItemView(manga: manga)
                                .onAppear {
                                    if manga == viewModel.mangas.last, !isLoadingNextPage {
                                        isLoadingNextPage = true
                                        Task {
                                            await viewModel.loadMoreMangas()
                                        }
                                        isLoadingNextPage = false
                                    }
                                }
                        }
                    }
                }
                .overlay(
                    LoadingIndicator(isLoading: viewModel.loadingIndicator),
                    alignment: .bottom
                )
            }
        }
    }
    
    struct LoadingIndicator: View {
        var isLoading: Bool

        var body: some View {
            if isLoading {
                ProgressView()
                    .controlSize(.large)
                    .padding(.vertical)
            } else {
                Color.clear
            }
        }
    }
    
    struct BestMangaListView: View {
        var bestMangas: [Manga]
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("Best Mangas")
                    .padding(.leading)
                    .font(.title)
                    .foregroundColor(.primary)
                    .bold()
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 16) {
                        ForEach(bestMangas) { manga in
                            NavigationLink(value: manga) {
                                MangaItemView(manga: manga)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    MangaListView()
        .environmentObject(MangaListViewModel.test)
}
