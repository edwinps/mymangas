//
//  Manga.swift
//  myMangas
//
//  Created by epena on 31/12/23.
//

import Foundation


enum DemographicType: String, Codable, CaseIterable, Identifiable {
    case seinen = "Seinen"
    case shounen = "Shounen"
    case shoujo = "Shoujo"
    case josei = "Josei"
    case kids = "Kids"
    var id: Self { self }
}

enum GenreType: String, Codable, CaseIterable, Identifiable {
    case none = "no Genre"
    case action = "Action"
    case adventure = "Adventure"
    case awardWinning = "Award Winning"
    case drama = "Drama"
    case fantasy = "Fantasy"
    case horror = "Horror"
    case supernatural = "Supernatural"
    case mystery = "Mystery"
    case sliceOfLife = "Slice of Life"
    case comedy = "Comedy"
    case sciFi = "Sci-Fi"
    case suspense = "Suspense"
    case sports = "Sports"
    case ecchi = "Ecchi"
    case romance = "Romance"
    case girlsLove = "Girls Love"
    case boysLove = "Boys Love"
    case gourmet = "Gourmet"
    case erotica = "Erotica"
    case hentai = "Hentai"
    case avantGarde = "Avant Garde"
    var id: Self { self }
}

struct Manga: Identifiable, Hashable {
    let id: Int
    let titleJapanese: String
    let authors: [String]
    let themes: [String]
    let title: String
    let endDate: String?
    let score: Double
    let status: String
    let demographics: [DemographicType]
    let genres: [GenreType]
    let startDate: String?
    let titleEnglish: String?
    let chapters: Int?
    let sypnosis: String
    let background: String
    let url: String
    let mainPicture: URL?
    let volumes: Int?
}
