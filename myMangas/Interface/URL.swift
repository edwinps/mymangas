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
    static let getBestMangas = api.appending(path: "list/bestMangas")
    
    //Categories
    static let getGenres = api.appending(path: "list/genres")
    static let getThemes = api.appending(path: "list/demographics")
    
    //Search
    static let getManga = api.appending(path: "search/manga")
    static let postSearchMangas = api.appending(path: "search/manga")
    
    //Login
    static let register = api.appending(path: "users")
    static let login = api.appending(path: "users/login")
    static let renew = api.appending(path: "users/renew")
    
    //Collection
    static let getCollections = api.appending(path: "collection/manga")
    static let postCollections = api.appending(path: "collection/manga")
}
