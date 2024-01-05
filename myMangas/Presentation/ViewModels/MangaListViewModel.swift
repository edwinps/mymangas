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
    
    // Filter
    @Published var selectedGenre: String? {
        didSet {
            applyFilters()
        }
    }
    @Published var selectedDemographic: String? {
        didSet {
            applyFilters()
        }
    }
    @Published var selectedTheme: String? {
        didSet {
            applyFilters()
        }
    }
    @Published var filteredMangas = [Manga]()
    @Published var filteredBestMangas = [Manga]()
    let demographics = DemographicType.allCases.map { $0.rawValue }
    var genres = [String]()
    var themes = [String]()
    
    init(network: DataInteractor = Network()) {
        self.network = network
        refreshData()
    }
    
    func clearFilters() {
        selectedGenre = nil
        selectedDemographic = nil
        selectedTheme = nil
    }
}

private extension MangaListViewModel {
    func refreshData() {
        Task {
            await MainActor.run { loading = true }
            await getGenres()
            await getThemes()
            await getBestMangas()
            await getAllMangas()
            await MainActor.run { applyFilters() }
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
    
    func getGenres() async {
        do {
            let genres = try await network.getGenres()
            await MainActor.run {
                self.genres = genres
            }
        } catch {
            print("Error: no genres")
        }
    }
    
    func getThemes() async {
        do {
            let themes = try await network.getThemes()
            await MainActor.run {
                self.themes = themes
            }
        } catch {
            print("Error: no themes")
        }
    }
    
    func applyFilters() {
        filteredMangas = applyFilters(for: mangas)
        filteredBestMangas = applyFilters(for: bestMangas)
    }
    
    
    func applyFilters(for mangas: [Manga]) -> [Manga] {
        return mangas.filter { manga in
            var matchesGenre = true
            var matchesDemographic = true
            var matchesTheme = true
            
            if let selectedGenre = selectedGenre {
                matchesGenre = manga.genres.contains(selectedGenre)
            }
            
            if let selectedDemographic = selectedDemographic, 
                let type = DemographicType(rawValue: selectedDemographic) {
                matchesDemographic = manga.demographics.contains(type)
            }
            
            if let selectedTheme = selectedTheme {
                matchesTheme = manga.themes.contains(selectedTheme)
            }
            
            return matchesGenre && matchesDemographic && matchesTheme
        }
    }
}
