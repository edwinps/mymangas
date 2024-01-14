//
//  MangaEditViewModel.swift
//  myMangas
//
//  Created by epena on 14/1/24.
//

import Foundation

final class MangaEditViewModel: ObservableObject {
    let manga: Manga
    
    @Published var isCompleted = false
    {
        didSet {
            print("value \(isCompleted)")
        }
    }
    @Published var selectedVolumes: [String] = [] {
        didSet {
            print("value \(selectedVolumes)")
        }
    }
    @Published var quantity: String = ""
    
    init(manga: Manga) {
        self.manga = manga
    }
    
    func updateManga() {
        print("isCompleted \(isCompleted) | selectedVolumes \(selectedVolumes) | quantity \(quantity)")
    }
}
