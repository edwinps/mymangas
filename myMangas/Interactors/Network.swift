//
//  Network.swift
//  myMangas
//
//  Created by epena on 31/12/23.
//

import Foundation

protocol DataInteractor {
    func getMangas() async throws -> [Manga]
    func getBestMangas() async throws -> [Manga]
    
    // Categories
    func getGenres() async throws -> [String]
    func getThemes() async throws -> [String]
    
    // Search
    func getManga(id: Int) async throws -> Manga
}

struct Network {
    func getJSON<JSON>(request: URLRequest, type: JSON.Type) async throws -> JSON where JSON: Codable {
        let (data, response) = try await URLSession.shared.getData(for: request)
        if response.statusCode == 200 {
            do {
                return try JSONDecoder().decode(type, from: data)
            } catch {
                throw NetworkError.json(error)
            }
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    func postJSON(request: URLRequest, status: Int = 200) async throws {
        let (_, response) = try await URLSession.shared.getData(for: request)
        if response.statusCode != status {
            throw NetworkError.status(response.statusCode)
        }
    }
}
