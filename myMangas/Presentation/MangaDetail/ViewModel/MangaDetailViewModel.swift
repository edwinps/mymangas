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
    @Published var imageOffset: CGFloat = 0
    
    private var network: DataInteractor
    @Published var isCompleted = false
    @Published var volumesOwned: [String] = []
    @Published var readingVolume: String = ""
    
    @Published var loading = false
    @Published var showAlert = false
    @Published var msg = ""
    
    init(network: DataInteractor = Network(),
         manga: Manga,
         isCompleted: Bool = false,
         volumesOwned: [String] = [],
         readingVolume: String = "") {
        self.network = network
        self.manga = manga
        self.isCompleted = isCompleted
        self.volumesOwned = volumesOwned
        self.readingVolume = readingVolume
    }
    
    func calculateNavBarOpacityAndImageOffset(offset: CGFloat, topInsetSize: CGFloat) {
        let newOffset = offset + topInsetSize
        let threshold: CGFloat = imageHeigt - topInsetSize + 10
        navBarOpacity = Double(min(1, -newOffset / threshold))
        
        if newOffset > 0 {
            imageOffset = min(0, -newOffset)
        } else {
            imageOffset = 0
        }
    }
    
    func calculateNavTitleOpacity(offset: CGFloat) {
        if offset  <= 0 {
            titteBarOpacity = 1
            navBarOpacity = 1
        } else {
            titteBarOpacity = 0
        }
    }
    
    func calculateImageoffset(offset: CGFloat, topInsetSize: CGFloat) {
        
    }
    
    func updateManga() {
        print("isCompleted \(isCompleted) | selectedVolumes \(volumesOwned) | quantity \(readingVolume)")
    }
    
    func postCollection() async -> Bool {
        await MainActor.run { [weak self] in self?.loading = true }
        let request = UserMangaCollectionRequest(manga: manga.id,
                                                 completeCollection: isCompleted,
                                                 volumesOwned: volumesOwned.map { Int($0) ?? 0 },
                                                 readingVolume: Int(readingVolume) ?? 0)
        do {
            try await network.postCollection(request: request)
            await MainActor.run { [weak self] in self?.loading = false }
            return true
        } catch {
            await MainActor.run { [weak self] in
                self?.msg = "There was an error try again later"
                self?.showAlert.toggle()
                self?.loading = false
            }
            return false
        }
    }
}
