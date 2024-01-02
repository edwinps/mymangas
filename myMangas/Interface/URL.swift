//
//  URL.swift
//  myMangas
//
//  Created by epena on 31/12/23.
//

import Foundation

let api = URL(string: "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/")!

extension URL {
    static let getMangas = api.appending(path: "list/mangas")
    static let getManga = api.appending(path: "search/manga")
    static let getBestMangas = api.appending(path: "list/bestMangas")
}
