//
//  myMangasApp.swift
//  myMangas
//
//  Created by epena on 31/12/23.
//

import SwiftUI

@main
struct myMangasApp: App {
    @StateObject var viewModel = MangaListViewModel()
    
    var body: some Scene {
        WindowGroup {
            MangaListView()
                .environmentObject(viewModel)
        }
    }
}
