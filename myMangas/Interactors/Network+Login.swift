//
//  Network+Login.swift
//  myMangas
//
//  Created by epena on 13/1/24.
//

import Foundation

struct UserCredentials: Codable {
    let email: String
    let password: String
}

extension Network {
    func register(credentials: UserCredentials) async throws {
        return try await postJSON(request: .post(url: .register,
                                                 data: credentials,
                                                 appToken: constants.registerToken))
    }
    
    mutating func login(credentials: UserCredentials) async throws {
        let credentialConcat = "\(credentials.email):\(credentials.password)"
        guard let encodedCredentials = credentialConcat.data(using: .utf8) else {
            throw NetworkError.noContent
        }
        let authorization = "Basic \(encodedCredentials.base64EncodedString())"
        
        let token = try await postToken(request: .post(url: .login,
                                                       data: credentials,
                                                       authorization: authorization))
        saveAuthToken(token)
    }
    
    mutating func renew() async throws {
        guard let token = loadAuthToken() else {
            throw NetworkError.noContent
        }
        let authorization = "Bearer \(token)"
        let newToken = try await postToken(request: .post(url: .renew,
                                                          authorization: authorization))
        logout()
        saveAuthToken(newToken)
    }
    
    mutating func logout() {
        keychainHelper.deleteData(key: constants.authTokenKey)
    }
}
