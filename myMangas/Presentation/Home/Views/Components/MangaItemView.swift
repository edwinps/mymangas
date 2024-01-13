//
//  MangaItemView.swift
//  myMangas
//
//  Created by epena on 2/1/24.
//

import SwiftUI

struct MangaItemView: View {
    var manga: Manga
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: manga.mainPicture) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 200, maxHeight: 300)
                    .cornerRadius(5)
                    .shadow(color: .black.opacity(0.7), radius: 5, x: 0, y: 5)
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
                .padding(.leading, 5)
                .font(.footnote)
                .foregroundColor(.primary)
                .bold()
                .lineLimit(2)
                .minimumScaleFactor(0.7)
        }
    }
}

#Preview {
    MangaItemView(manga: Manga.testMonter)
}
