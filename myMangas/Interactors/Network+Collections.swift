//
//  Network+Collections.swift
//  myMangas
//
//  Created by epena on 25/1/24.
//

import Foundation

extension Network {
    mutating func getCollection() async throws -> [CollectionModel] {
        guard let token = loadAuthToken() else {
            throw NetworkError.noContent
        }
        let authorization = "Bearer \(token)"
        return try await getJSON(request: .get(url: .getCollections,
                                        authorization: authorization),
                                 type: [CollectionDTO].self).map(\.toPresentation)
    }
    
    mutating func postCollection(request: UserMangaCollectionRequest) async throws {
        guard let token = loadAuthToken() else {
            throw NetworkError.noContent
        }
        let authorization = "Bearer \(token)"
        
        return try await postJSON(request: .post(url: .postCollections,
                                                 data: request,
                                                 appToken: constants.registerToken,
                                                 authorization: authorization))
    }
}
