//
//  TabView.swift
//  myMangas
//
//  Created by epena on 13/1/24.
//

import SwiftUI

struct MangaTabView: View {
    @State private var tabSelection = 0
    @StateObject private var homeViewModel = MangaListViewModel()
    @StateObject private var accountViewModel = AccountViewModel()
    @StateObject private var myListViewModel = MyListViewModel()
    
    var body: some View {
        TabView(selection: $tabSelection) {
            MangaListView()
                .environmentObject(homeViewModel)
                .tabItem {
                    Label("Home", systemImage: "house")
                }.tag(0)
            
            MyListView(tabSelection: $tabSelection, viewModel: myListViewModel)
                .tabItem {
                    Label("My List", systemImage: "list.bullet")
                }.tag(1)
            
            AccountView(viewModel: accountViewModel)
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle")
                }.tag(2)
        }
    }
}


#Preview {
    MangaTabView()
}
