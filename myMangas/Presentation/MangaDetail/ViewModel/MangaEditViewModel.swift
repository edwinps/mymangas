//
//  MangaEditViewModel.swift
//  myMangas
//
//  Created by epena on 14/1/24.
//

import Foundation

final class MangaEditViewModel: ObservableObject {
    let manga: Manga
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
