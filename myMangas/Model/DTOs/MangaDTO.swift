//
//  MangaDTO.swift
//  myMangas
//
//  Created by epena on 31/12/23.
//

import Foundation

struct MangaDTO: Codable {
    let id: Int
    let titleJapanese: String
    let sypnosis: String
    let titleEnglish: String?
    let chapters: Int?
    let themes: [Theme]
    let authors: [AuthorDTO]
    let title, status: String
    let startDate: String?
    let url: String
    let demographics: [Demographic]
    let background: String
    let mainPicture: String
    let genres: [Genre]
    let endDate: String?
    let volumes: Int?
    let score: Double
}

extension MangaDTO {
    var toPresentation: Manga {
        Manga(id: id,
              titleJapanese: titleJapanese,
              authors: authors.map(\.toPresentation),
              themes: themes.map(\.theme),
              title: title,
              endDate: endDate,
              score: score,
              status: status,
              demographics: demographics.map(\.demographic),
              genres: genres.map(\.genre),
              startDate: startDate,
              titleEnglish: titleEnglish,
              chapters: chapters,
              sypnosis: sypnosis,
              background: background,
              url: url,
              mainPicture: URL(string:mainPicture.trimmingCharacters(in: .init(charactersIn: "\""))),
              volumes: volumes)
    }
}
