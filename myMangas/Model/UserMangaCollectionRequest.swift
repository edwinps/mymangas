//
//  UserMangaCollectionRequest.swift
//  myMangas
//
//  Created by epena on 28/1/24.
//

import Foundation

struct UserMangaCollectionRequest: Codable {
    var manga: Int
    var completeCollection: Bool
    var volumesOwned: [Int]
    var readingVolume: Int?
}
