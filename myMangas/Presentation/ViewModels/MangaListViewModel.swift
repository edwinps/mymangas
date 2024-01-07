//
//  MangaListViewModel.swift
//  myMangas
//
//  Created by epena on 2/1/24.
//

import Foundation

final class MangaListViewModel: ObservableObject {
    private let network: DataInteractor
    private var bestMangas = [Manga]()
    private var currentPage = 1
    private var noMorePages = false
    private var searchDebouncer = Debouncer()
    
    @Published var mangas = [Manga]()
    @Published var loading = true
    @Published var loadingIndicator = false
    @Published var showAlert = false
    @Published var msg = ""
    
    // Filter
    @Published var selectedGenre: String?
    @Published var selectedDemographic: String?
    @Published var selectedTheme: String?
    @Published var filteredBestMangas = [Manga]()
    var isFiltered: Bool {
        selectedGenre != nil
        || selectedDemographic != nil
        || selectedTheme != nil
    }
    let demographics = DemographicType.allCases.map { $0.rawValue }
    var genres = [String]()
    var themes = [String]()
    
    init(network: DataInteractor = Network()) {
        self.network = network
        getAllData()
    }
    
    func loadMoreMangas() async {
        guard !noMorePages else {
            return
        }
        currentPage += 1
        await MainActor.run {
            loadingIndicator = true
            filteredBestMangas = applyFilters(for: bestMangas)
        }
        await (isFiltered ? searchMangas() : getMangas())
        await MainActor.run {
            loadingIndicator = false
        }
    }
    
    func applyFilters(_ query: String? = nil) async {
        noMorePages = false
        await MainActor.run {
            filteredBestMangas = applyFilters(for: bestMangas)
            mangas = []
        }
        currentPage = 1
        await searchMangas(query)
    }
    
    func clearFilters() {
        selectedGenre = nil
        selectedDemographic = nil
        selectedTheme = nil
    }
    
    func performSearch(query: String) {
        searchDebouncer.debounce(delay: 0.5) {
            Task {
                await self.applyFilters(query)
            }
        }
    }
}

// MARK: Filters methods
private extension MangaListViewModel {
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

// MARK: get data
private extension MangaListViewModel {
    func getAllData() {
        clearFilters()
        currentPage = 1
        noMorePages = false
        Task {
            await MainActor.run { loading = true }
            await getGenres()
            await getThemes()
            await getBestMangas()
            await getMangas()
            await MainActor.run {
                filteredBestMangas = applyFilters(for: bestMangas)
                loading = false
            }
        }
    }
    
    func getBestMangas() async {
        do {
            let bestMangas = try await network.getBestMangas()
            await MainActor.run {
                self.bestMangas = bestMangas
            }
        } catch {
            await MainActor.run {
                self.msg = "\(error)"
                self.showAlert.toggle()
            }
        }
    }
    
    func getMangas() async {
        do {
            let mangas = try await network.getMangas(page: currentPage)
            noMorePages = mangas.isEmpty
            await MainActor.run {
                self.mangas += mangas
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
}

// MARK: search data
private extension MangaListViewModel {
    func searchMangas(_ query: String? = nil) async {
        do {
            let customSearch = CustomSearch(searchTitle: query,
                                            searchGenres: [selectedGenre ?? ""],
                                            searchThemes: [selectedTheme ?? ""],
                                            searchDemographics: [selectedDemographic ?? ""],
                                            searchContains: true)
            let mangas = try await network.searchMangas(page: currentPage, bodyItems: customSearch)
            noMorePages = mangas.isEmpty
            await MainActor.run {
                self.mangas += mangas
            }
        } catch {
            await MainActor.run {
                self.msg = "\(error)"
                self.showAlert.toggle()
            }
        }
    }
}


