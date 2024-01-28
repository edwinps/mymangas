//
//  MangaDetailViewModel.swift
//  myMangas
//
//  Created by epena on 27/1/24.
//

import Foundation

final class MangaDetailViewModel: ObservableObject {
    let manga: Manga
    @Published var imageHeigt: CGFloat = 50
    @Published var navBarOpacity: Double = 0
    @Published var titteBarOpacity: Double = 0
    
    init(manga: Manga = Manga.testMonter) {
        self.manga = manga
    }
    
    func calculateNavBarOpacity(offset: CGFloat, topInsetSize: CGFloat) {
        let newOffset = offset + topInsetSize
        let threshold: CGFloat = imageHeigt - topInsetSize + 10
        navBarOpacity = Double(min(1, -newOffset / threshold))
    }
    
    func calculateNavTitleOpacity(offset: CGFloat) {
        if offset  <= 0 {
            titteBarOpacity = 1
            navBarOpacity = 1
        } else {
            titteBarOpacity = 0
        }
    }
}
