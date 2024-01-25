//
//  Network+Collections.swift
//  myMangas
//
//  Created by epena on 25/1/24.
//

import Foundation

extension Network {
    mutating func getCollection() async throws -> [Manga] {
        guard let token = loadAuthToken() else {
            throw NetworkError.noContent
        }
        let authorization = "Bearer \(token)"
        return try await getJSON(request: .get(url: .getCollections,
                                        authorization: authorization),
                                 type: [MangaDTO].self).map(\.toPresentation)
    }
}
