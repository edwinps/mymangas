//
//  MangaDetailView.swift
//  myMangas
//
//  Created by epena on 14/1/24.
//

import SwiftUI

struct MangaDetailView: View {
    let manga: Manga
    
    init(manga: Manga) {
        self.manga = manga
        UIScrollView.appearance().bounces = false
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: manga.mainPicture) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: 300)
                        .cornerRadius(10)
                        .overlay(
                            VStack {
                                Spacer()
                                Text(manga.title)
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .bold()
                                    .padding(4)
                            }
                        )
                }
                Text(manga.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding([.leading, .trailing])
                
                if !manga.genres.isEmpty {
                    Text("\(manga.genres.map {$0.capitalized }.joined(separator: " | "))")
                        .padding([.leading, .trailing])
                }
                
                if !manga.demographics.isEmpty {
                    Text("\(manga.demographics.map { $0.rawValue.capitalized }.joined(separator: " | "))")
                        .padding([.leading, .trailing])
                }
                
                if let volumes = manga.volumes {
                    Text("Volumes: \(volumes)")
                        .padding([.leading, .trailing])
                }
                
                NavigationLink(value: manga.id) {
                        Text("Add to your collection")
                        .padding([.leading, .trailing])
                }
                
                if let synopsis = manga.sypnosis {
                    Text("Synopsis:")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding([.leading, .trailing])
                    Text(synopsis)
                        .padding([.leading, .trailing])
                }
                Spacer()
            }
        }
        .navigationDestination(for: Int.self) { _ in
            MangaEditView(viewModel: MangaEditViewModel(manga: manga))
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    NavigationStack {
        MangaDetailView(manga: Manga.testBerserk)
    }
}

