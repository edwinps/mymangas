//
//  Network.swift
//  myMangas
//
//  Created by epena on 31/12/23.
//

import Foundation

protocol DataInteractor {
    func getMangas(page: Int) async throws -> [Manga]
    func getBestMangas() async throws -> [Manga]
    func getManga(id: Int) async throws -> Manga
    
    // Categories
    func getGenres() async throws -> [String]
    func getThemes() async throws -> [String]
    
    // Search
    func searchMangas(page: Int, bodyItems: CustomSearch) async throws -> [Manga]
    
    // Login
    func register(credentials: UserCredentials) async throws
    mutating func login(credentials: UserCredentials) async throws
    mutating func renew() async throws
    mutating func logout()
    mutating func isLogin() -> Bool
    
    // Collection
    mutating func getCollection() async throws -> [CollectionModel]
    mutating func postCollection(request: UserMangaCollectionRequest) async throws
}

struct Network {
    internal let keychainHelper: KeychainHelper
    private var authToken: String?
    
    init(keychainHelper: KeychainHelper = KeychainHelper()) {
        self.keychainHelper = keychainHelper
    }
    
    struct constants {
        static let pageKey = "page"
        static let itemPerPageKey = "per"
        static let itemPerPage = 20
        static let registerToken = "sLGH38NhEJ0_anlIWwhsz1-LarClEohiAHQqayF0FY"
        static let authTokenKey = "authToken"
    }
        
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
    
    func postJSON<JSON>(request: URLRequest, type: JSON.Type) async throws -> JSON where JSON: Codable {
        let (data, response) = try await URLSession.shared.getData(for: request)
        if response.statusCode / 100 == 2 {
            do {
                return try JSONDecoder().decode(type, from: data)
            } catch {
                throw NetworkError.json(error)
            }
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    func postToken(request: URLRequest) async throws -> String {
        let (data, response) = try await URLSession.shared.getData(for: request)
        if response.statusCode / 100 == 2, let token = String(data: data, encoding: .utf8) {
            return token
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    func postJSON(request: URLRequest) async throws {
        let (_, response) = try await URLSession.shared.getData(for: request)

        guard response.statusCode / 100 == 2 else {
            throw NetworkError.status(response.statusCode)
        }
    }
}

internal extension Network {
    mutating func saveAuthToken(_ token: String) {
        if let data = token.data(using: .utf8) {
            keychainHelper.saveData(key: constants.authTokenKey, data: data)
        }
        self.authToken = token
    }
    
    mutating func loadAuthToken() -> String? {
        if let data = keychainHelper.loadData(key: constants.authTokenKey),
           let token = String(data: data, encoding: .utf8) {
            self.authToken = token
            return token
        } else {
            return nil
        }
    }
}
