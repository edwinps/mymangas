//
//  URLRequest.swift
//  myMangas
//
//  Created by epena on 31/12/23.
//

import Foundation

extension URLRequest {
    static func get(url: URL, queryParams: [URLQueryItem]? = nil) -> URLRequest {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = queryParams
        var request = URLRequest(url: urlComponents?.url ?? url)
        request.timeoutInterval = 60
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    static func post<JSON>(url: URL, data: JSON, queryParams: [URLQueryItem]? = nil) -> URLRequest where JSON: Codable {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = queryParams
        var request = URLRequest(url: urlComponents?.url ?? url)
        request.timeoutInterval = 60
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(data)
        return request
    }
}
