//
//  NetworkError.swift
//  myMangas
//
//  Created by epena on 31/12/23.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case general(Error)
    case status(Int)
    case noContent
    case json(Error)
    case unknown
    case noHTTP
    
    public var description: String {
        switch self {
        case .general(let error):
            return "General Error: \(error.localizedDescription)"
        case .status(let int):
            return "Status Error: \(int)"
        case .noContent:
            return "Content does not match the expected format"
        case .unknown:
            return "Unknown Error"
        case .noHTTP:
            return "Not an HTTP call"
        case .json(let error):
            return "JSON error: \(error)"
        }
    }
}
