//
//  MyListView.swift
//  myMangas
//
//  Created by epena on 22/1/24.
//

import SwiftUI

struct MyListView2: View {
    @ObservedObject var viewModel: MyListViewModel

    var body: some View {
        VStack {
            Text("My Collections")
                .font(.title)
                .foregroundColor(.primary)
                .bold()
            List(viewModel.mangas) { manga in
                HStack(alignment: .top) {
                    AsyncImage(url: manga.mainPicture) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 150)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.primary, lineWidth: 1)
                            )
                    } placeholder: {
                        Color.gray
                            .frame(height: 100)
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text(manga.title)
                            .font(.headline)

                        if !manga.genres.isEmpty {
                            Text("\(manga.genres.map {$0.capitalized }.joined(separator: " | "))")
                        }

                        if !manga.demographics.isEmpty {
                            Text("\(manga.demographics.map { $0.rawValue.capitalized }.joined(separator: " | "))")
                        }

                        if let volumes = manga.volumes {
                            Text("Volumes: \(1)/\(volumes)")
                        }

                        HStack {
                            let completed = Bool.random()
                            Text(completed ? "Completed" : "Incompleted")
                            Image(systemName: completed ? "star.fill" : "star")
                                .foregroundColor(completed ? .yellow : .gray)
                            
                        }
                    }
                }
                .padding(.vertical, 10)
                .listRowSeparator(.hidden)
            }
            .listStyle(PlainListStyle())
        .background(Color.clear)
        }
    }
}

#Preview {
    MyListView2(viewModel: .test)
}
