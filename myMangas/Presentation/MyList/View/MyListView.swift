//
//  MyListView.swift
//  myMangas
//
//  Created by epena on 22/1/24.
//

import SwiftUI

struct MyListView: View {
    @Binding var tabSelection: Tab
    @ObservedObject var viewModel: MyListViewModel
    @Binding var path: [MangaNavigation]
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Text("My Collections")
                    .font(.title)
                    .foregroundColor(.primary)
                    .bold()
                if viewModel.errorState != errorState.none {
                    Spacer()
                    Text(viewModel.errorState.message)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding(20)
                    if !viewModel.errorState.action.isEmpty {
                        Button(viewModel.errorState.action) {
                            switch viewModel.errorState {
                            case .noLogin:
                                tabSelection = .account
                            case .noCollection, .general:
                                Task {
                                    await viewModel.getCollectionMangas()
                                }
                            case .none: break
                            }
                        }
                    }
                    Spacer()
                } else {
                    List(viewModel.collections) { collection in
                        CollectionViewItem(collection: collection)
                    }
                    .refreshable {
                        Task {
                            await viewModel.getCollectionMangas()
                        }
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.clear)
                }
            }
            .navigationBarHidden(false)
            .navigationDestination(for: MangaNavigation.self) { screen in
                switch screen {
                case .detail(let viewModel):
                    MangaDetailView(viewModel: viewModel)
                case .edit(let viewModel):
                    MangaEditView(viewModel: viewModel)
                }
            }
            .onAppear {
                Task {
                    await viewModel.getCollectionMangas()
                }
            }
        }
    }
}

private extension MyListView {
    struct CollectionViewItem: View {
        var collection: CollectionModel
        
        var body: some View {
            let readingVolume = String(collection.readingVolume ?? 0)
            let viewModel = MangaDetailViewModel(
                manga: collection.manga,
                isCompleted: collection.completeCollection,
                volumesOwned: collection.volumesOwned.map { String($0) } ,
                readingVolume: readingVolume == "0" ? "" : readingVolume
            )
            NavigationLink(value: MangaNavigation.detail(viewModel)) {
                HStack(alignment: .top) {
                    AsyncImage(url: collection.manga.mainPicture) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 150)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.primary, lineWidth: 1)
                            )
                    } placeholder: {
                        Color.gray
                            .frame(width: 100, height: 150)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(collection.manga.title)
                            .font(.headline)
                        
                        let volumes = collection.manga.volumes ?? 0
                        let readingVolumes = collection.readingVolume ?? 0
                        let volumesString = volumes == 0 ? "?" : String(volumes)
                        HStack {
                            Image(systemName: "book.fill")
                                .foregroundColor(.blue)
                            Text("Reading \(readingVolumes)/\(volumesString) volumes")
                        }
                        
                        HStack {
                            let volumnText = collection.volumesOwned.count > 1 ? "volumes" : "volume"
                            Image(systemName: "square.grid.2x2.fill")
                                .foregroundColor(.green)
                            Text("You own: \(collection.volumesOwned.map { String($0).capitalized }.joined(separator: " | ")) \(volumnText)")
                        }
                        
                        HStack {
                            let completed = collection.completeCollection
                            Image(systemName: completed ? "star.fill" : "star")
                                .foregroundColor(completed ? .yellow : .gray)
                            Text(completed ? "Completed Collection" : "Incomplete Collection")
                        }
                    }
                }
                .padding(.vertical, 10)
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        }
    }
}

#Preview {
    NavigationStack {
        MyListView(tabSelection: .constant(Tab.myList),
                   viewModel: .test,
                   path: .constant([]))
    }
}
