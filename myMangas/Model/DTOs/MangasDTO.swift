//
//  MangasDTO.swift
//  myMangas
//
//  Created by epena on 31/12/23.
//

import Foundation

struct MangasDTO: Codable {
    let metadata: Metadata
    let items: [MangaDTO]?
}

struct AuthorDTO: Codable {
    let id: String
    let role: String
    let firstName: String
    let lastName: String
}

struct Demographic: Codable {
    let id: String
    let demographic: DemographicType
}

struct Genre: Codable {
    let id: String
    let genre: String
}

struct Theme: Codable {
    let id: String
    let theme: String
}

struct Metadata: Codable {
    let total, page, per: Int
}

extension AuthorDTO {
    var toPresentation: Author {
        Author(id: id, Name: firstName + " " + lastName)
    }
}
