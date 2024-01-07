//
//  Network+Search.swift
//  myMangas
//
//  Created by epena on 7/1/24.
//

import Foundation

struct CustomSearch: Codable {
    var searchTitle: String?
    var searchAuthorFirstName: String?
    var searchAuthorLastName: String?
    var searchGenres: [String]?
    var searchThemes: [String]?
    var searchDemographics: [String]?
    var searchContains: Bool
}

extension Network {
    func getManga(id: Int) async throws -> Manga {
        let searchMangaURL = URL.getManga.appendingPathComponent(String(id))
        return try await getJSON(request: .get(url: searchMangaURL),
                                 type: MangaDTO.self).toPresentation
    }
    
    func searchMangas(page: Int, bodyItems: CustomSearch) async throws -> [Manga] {
        let queryParams = [
            URLQueryItem(name: constants.pageKey, value: "\(page)"),
            URLQueryItem(name: constants.itemPerPageKey, value: "\(constants.itemPerPage)"),
        ]
        return try await postJSON(request: .post(url: .postSearchMangas, data: bodyItems,
                                                 queryParams: queryParams),
                                  type: MangasDTO.self).items?.map(\.toPresentation) ?? []
    }
}
