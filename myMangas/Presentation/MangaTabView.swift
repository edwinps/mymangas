//
//  TabView.swift
//  myMangas
//
//  Created by epena on 13/1/24.
//

import SwiftUI

struct MangaTabView: View {
    @StateObject private var homeViewModel = MangaListViewModel()
    @StateObject private var accountViewModel = AccountViewModel()
    
    var body: some View {
        TabView {
            MangaListView()
                .environmentObject(homeViewModel)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            MyListView()
                .tabItem {
                    Label("My List", systemImage: "list.bullet")
                }
            
            AccountView(viewModel: accountViewModel)
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle")
                }
        }
    }
}

struct MyListView: View {
    var body: some View {
        Text("MyListView")
            .font(.title)
            .foregroundColor(.primary)
            .bold()
    }
}


#Preview {
    MangaTabView()
}
