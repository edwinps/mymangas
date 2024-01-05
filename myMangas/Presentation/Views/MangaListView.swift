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
                    BestMangaListView(bestMangas: viewModel.filteredBestMangas)
                        .frame(height: UIScreen.main.bounds.height / 3)
                    
                    MangaListViewGrid(mangas: viewModel.filteredMangas)
                        .padding()
                }
                .navigationBarItems(leading: HStack {
                    Button("Filters") {
                        showFilterSheet.toggle()
                    }
                })
                .navigationBarItems(
                    trailing: Button(action: {
                        
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                )
            }.sheet(isPresented: $showFilterSheet) {
                FilterView(isPresented: $showFilterSheet)
            }
        }
    }
}

private extension MangaListView{
    struct MangaListViewGrid: View {
        var mangas: [Manga]
        
        var body: some View {
            
            VStack(alignment: .leading) {
                Text("Mangas")
                    .font(.title)
                    .foregroundColor(.primary)
                    .bold()
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
                    ForEach(mangas) { manga in
                        MangaItemView(manga: manga)
                    }
                }
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
                            MangaItemView(manga: manga)
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
