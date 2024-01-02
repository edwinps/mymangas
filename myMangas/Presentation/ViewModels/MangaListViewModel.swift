//
//  MangaListViewModel.swift
//  myMangas
//
//  Created by epena on 2/1/24.
//

import Foundation

final class MangaListViewModel: ObservableObject {
    private let network: DataInteractor
    private var mangas = [Manga]()
    private var bestMangas = [Manga]()
    @Published var loading = true
    @Published var showAlert = false
    @Published var msg = ""
    @Published var filteredMangas = [Manga]()
    @Published var filteredBestMangas = [Manga]()
    
    init(network: DataInteractor = Network()) {
        self.network = network
        refreshData()
    }
    
    func filteredMangas(for selectedGenre: GenreType?) {
        if let genre = selectedGenre, genre != .none  {
            filteredMangas = mangas.filter { $0.genres.contains(genre) }
            filteredBestMangas = bestMangas.filter { $0.genres.contains(genre) }
        } else {
            filteredMangas = mangas
            filteredBestMangas = bestMangas
        }
    }
}

private extension MangaListViewModel {
    
    func refreshData() {
        Task {
            await MainActor.run { loading = true }
            await getBestMangas()
            await getAllMangas()
            await MainActor.run { filteredMangas(for: nil) }
            await MainActor.run { loading = false }
        }
    }
    
    func getBestMangas() async {
        do {
            let mangas = try await network.getMangas()
            await MainActor.run {
                self.bestMangas = mangas
            }
        } catch {
            await MainActor.run {
                self.msg = "\(error)"
                self.showAlert.toggle()
            }
        }
    }
    
    func getAllMangas() async {
        do {
            let mangas = try await network.getBestMangas()
            await MainActor.run {
                self.mangas = mangas
            }
        } catch {
            await MainActor.run {
                self.msg = "\(error)"
                self.showAlert.toggle()
            }
        }
    }
    
    func getGenres()-> [GenreType]  {
        return [.action, .adventure]
    }
}
