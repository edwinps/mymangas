//
//  Network+Mangas.swift
//  myMangas
//
//  Created by epena on 31/12/23.
//

import Foundation

extension Network: DataInteractor {
    func getMangas(page: Int) async throws -> [Manga] {
        let queryParams = [
            URLQueryItem(name: constants.pageKey, value: "\(page)"),
            URLQueryItem(name: constants.itemPerPageKey, value: "\(constants.itemPerPage)"),
        ]
        return try await getJSON(request: .get(url: .getMangas, queryParams: queryParams),
                          type: MangasDTO.self).items?.map(\.toPresentation) ?? []
    }
    
    func getBestMangas() async throws -> [Manga] {
        try await getJSON(request: .get(url: .getBestMangas), type: MangasDTO.self).items?.map(\.toPresentation) ?? []
    }
}
