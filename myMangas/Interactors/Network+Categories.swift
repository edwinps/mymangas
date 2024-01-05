//
//  Network+Categories.swift
//  myMangas
//
//  Created by epena on 5/1/24.
//

import Foundation

extension Network {
    func getGenres() async throws -> [String] {
        try await getJSON(request: .get(url: .getGenres), type: [String].self)
    }
    
    func getThemes() async throws -> [String] {
        try await getJSON(request: .get(url: .getThemes), type: [String].self)
    }
}
