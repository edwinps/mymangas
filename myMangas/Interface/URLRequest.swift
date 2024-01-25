//
//  URLRequest.swift
//  myMangas
//
//  Created by epena on 31/12/23.
//

import Foundation

extension URLRequest {
    static func get(url: URL, 
                    queryParams: [URLQueryItem]? = nil,
                    authorization: String? = nil) -> URLRequest {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = queryParams
        var request = URLRequest(url: urlComponents?.url ?? url)
        request.timeoutInterval = 60
        request.httpMethod = "GET"
        if let authorization {
            request.setValue(authorization, forHTTPHeaderField: "Authorization")
        }
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    static func post<JSON>(url: URL,
                           data: JSON,
                           queryParams: [URLQueryItem]? = nil,
                           appToken: String? = nil,
                           authorization: String? = nil) -> URLRequest where JSON: Codable {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = queryParams
        var request = URLRequest(url: urlComponents?.url ?? url)
        request.timeoutInterval = 60
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if let appToken {
            request.setValue(appToken, forHTTPHeaderField: "App-Token")
        }
        if let authorization {
            request.setValue(authorization, forHTTPHeaderField: "Authorization")
        }
        if let jsonData = try? JSONEncoder().encode(data) {
            request.httpBody = jsonData
        }
        return request
    }
    
    static func post(url: URL,
                     queryParams: [URLQueryItem]? = nil,
                     authorization: String? = nil) -> URLRequest {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = queryParams
        var request = URLRequest(url: urlComponents?.url ?? url)
        request.timeoutInterval = 60
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if let authorization {
            request.setValue(authorization, forHTTPHeaderField: "Authorization")
        }
        return request
    }
}
