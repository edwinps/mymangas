//
//  CollectionsDTO.swift
//  myMangas
//
//  Created by epena on 28/1/24.
//

import Foundation

struct CollectionDTO: Codable {
    let id: String
    let manga: MangaDTO
    let user: userDTO?
    let volumesOwned: [Int]
    let readingVolume: Int?
    let completeCollection: Bool
}

struct userDTO: Codable {
    let id: String
}


extension CollectionDTO {
    var toPresentation: CollectionModel {
        CollectionModel(id: id, 
                   manga: manga.toPresentation,
                   volumesOwned: volumesOwned,
                   readingVolume: readingVolume,
                   completeCollection: completeCollection)
    }
}
