//
//  MyListViewModel.swift
//  myMangas
//
//  Created by epena on 22/1/24.
//

import Foundation

enum errorState {
    case noLogin
    case noCollection
    case general
    case none
    
    var message: String {
        switch self {
        case .noLogin: "You need to log in to view your collections."
        case .noCollection: "You don't have any collection, add some manga to your collection"
        case .general: "There was a problem try again later"
        case .none: ""
        }
    }
    
    var action: String {
        switch self {
        case .noLogin: "Login"
        case .noCollection: "Refresh"
        case .general: "Refresh"
        case .none: ""
        }
    }
}

final class MyListViewModel: ObservableObject {
    private var network: DataInteractor
    @Published var mangas = [Manga]()
    @Published var errorState :errorState = .none
    
    init(network: DataInteractor = Network()) {
        self.network = network
    }
}

extension MyListViewModel {
    func getCollectionMangas() async {
        guard network.isLogin() else {
            await MainActor.run {
                errorState = .noLogin
            }
            return
        }
        do {
            let mangas = try await network.getCollection()
            guard !mangas.isEmpty else {
                await MainActor.run {
                    errorState = .noCollection
                }
                return
            }
            await MainActor.run {
                self.mangas = mangas
                errorState = .none
            }
        } catch {
            await MainActor.run {
                errorState = .general
            }
        }
    }
}
