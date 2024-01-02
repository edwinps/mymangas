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
            "General Error: \(error.localizedDescription)"
        case .status(let int):
            "Status Error: \(int)"
        case .noContent:
            " El contenido no se corresponde con lo esperado"
        case .unknown:
            "Error desconocido"
        case .noHTTP:
            "No es una llamada HTTP"
        case .json(let error):
            "JSON error: \(error)"
        }
    }
}
