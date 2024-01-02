//
//  Network+Mangas.swift
//  myMangas
//
//  Created by epena on 31/12/23.
//

import Foundation

protocol DataInteractor {
    func getMangas() async throws -> [Manga]
    func getManga(id: Int) async throws -> Manga
    func getBestMangas() async throws -> [Manga]
}


extension Network: DataInteractor {
    func getMangas() async throws -> [Manga] {
        try await getJSON(request: .get(url: .getMangas), type: MangasDTO.self).items.map(\.toPresentation)
    }
    
    func getManga(id: Int) async throws -> Manga {
        try await getJSON(request: .get(url: .getManga), type: MangaDTO.self).toPresentation
    }
    
    func getBestMangas() async throws -> [Manga] {
        try await getJSON(request: .get(url: .getBestMangas), type: MangasDTO.self).items.map(\.toPresentation)
    }
}
