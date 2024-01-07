//
//  Manga.swift
//  myMangas
//
//  Created by epena on 31/12/23.
//

import Foundation


enum DemographicType: String, Codable, CaseIterable, Identifiable, Hashable {
    case seinen = "Seinen"
    case shounen = "Shounen"
    case shoujo = "Shoujo"
    case josei = "Josei"
    case kids = "Kids"
    var id: Self { self }
}

struct Author: Identifiable, Hashable {
    let id: String
    let Name: String
}

struct Manga: Identifiable, Hashable {
    let id: Int
    let titleJapanese: String?
    let authors: [Author]
    let themes: [String]
    let title: String
    let endDate: String?
    let score: Double?
    let status: String?
    let demographics: [DemographicType]
    let genres: [String]
    let startDate: String?
    let titleEnglish: String?
    let chapters: Int?
    let sypnosis: String?
    let background: String?
    let url: String?
    let mainPicture: URL?
    let volumes: Int?
}
