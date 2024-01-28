//
//  Collection.swift
//  myMangas
//
//  Created by epena on 28/1/24.
//

import Foundation

struct CollectionModel: Identifiable, Hashable {
    let id: String
    let manga: Manga
    let volumesOwned: [Int]
    let readingVolume: Int?
    let completeCollection: Bool
}
