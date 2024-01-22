//
//  MyListViewModel.swift
//  myMangas
//
//  Created by epena on 22/1/24.
//

import Foundation

final class MyListViewModel: ObservableObject {
    private let network: DataInteractor
    @Published var mangas: [Manga] = [.testMonter, .testBerserk, .testMonter, .testBerserk]
    
    init(network: DataInteractor = Network()) {
        self.network = network
    }
}
