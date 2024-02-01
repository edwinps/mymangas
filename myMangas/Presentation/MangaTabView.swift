//
//  TabView.swift
//  myMangas
//
//  Created by epena on 13/1/24.
//

import SwiftUI
enum Tab {
    case mangaList, myList, account
}

enum MangaNavigation: Hashable {
    case detail(MangaDetailViewModel)
    case edit(MangaDetailViewModel)
    
    static func == (lhs: MangaNavigation, rhs: MangaNavigation) -> Bool {
        switch (lhs, rhs) {
        case let (.detail(viewModel1), .detail(viewModel2)):
            return viewModel1.manga.id == viewModel2.manga.id
        case let (.edit(viewModel1), .edit(viewModel2)):
            return viewModel1.manga.id == viewModel2.manga.id
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .detail(let viewModel):
            return hasher.combine(viewModel.manga.id)
        case .edit(let viewModel):
            return hasher.combine(viewModel.manga.id)
        }
    }
}


struct MangaTabView: View {
    @State private var selectedTab: Tab = .mangaList
    @StateObject private var mangaListViewModel = MangaListViewModel()
    @StateObject private var accountViewModel = AccountViewModel()
    @StateObject private var myListViewModel = MyListViewModel()
    
    @State private var listNavigationStack: [MangaNavigation] = []
    @State private var collectionNavigationStack: [MangaNavigation] = []
    
    var body: some View {
        TabView(selection: tabSelection()) {
            MangaListView(path: $listNavigationStack)
                .environmentObject(mangaListViewModel)
                .tabItem {
                    Label("Home", systemImage: "house")
                }.tag(Tab.mangaList)
            
            MyListView(tabSelection: $selectedTab, 
                       viewModel: myListViewModel, 
                       path: $collectionNavigationStack)
                .tabItem {
                    Label("My List", systemImage: "list.bullet")
                }.tag(Tab.myList)
            
            AccountView(viewModel: accountViewModel)
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle")
                }.tag(Tab.account)
        }
    }
}
private extension MangaTabView {
    
    func tabSelection() -> Binding<Tab> {
        Binding {
            self.selectedTab
        } set: { tappedTab in
            print("tab \(self.selectedTab)")
            if tappedTab == self.selectedTab {
                if !listNavigationStack.isEmpty, tappedTab == .mangaList {
                    listNavigationStack = []
                }
                
                if !collectionNavigationStack.isEmpty, tappedTab == .myList  {
                    collectionNavigationStack = []
                }
            }
            self.selectedTab = tappedTab
        }
    }
}

#Preview {
    MangaTabView()
}
