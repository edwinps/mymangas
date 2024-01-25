//
//  MyListView.swift
//  myMangas
//
//  Created by epena on 22/1/24.
//

import SwiftUI

struct MyListView: View {
    @Binding var tabSelection: Int
    @ObservedObject var viewModel: MyListViewModel
    
    var body: some View {
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
                            tabSelection = 2
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
                List(viewModel.mangas) { manga in
                    HStack(alignment: .top) {
                        AsyncImage(url: manga.mainPicture) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 150)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.primary, lineWidth: 1)
                                )
                        } placeholder: {
                            Color.gray
                                .frame(height: 100)
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(manga.title)
                                .font(.headline)
                            
                            if !manga.genres.isEmpty {
                                Text("\(manga.genres.map {$0.capitalized }.joined(separator: " | "))")
                            }
                            
                            if !manga.demographics.isEmpty {
                                Text("\(manga.demographics.map { $0.rawValue.capitalized }.joined(separator: " | "))")
                            }
                            
                            if let volumes = manga.volumes {
                                Text("Volumes: \(1)/\(volumes)")
                            }
                            
                            HStack {
                                let completed = Bool.random()
                                Text(completed ? "Completed" : "Incompleted")
                                Image(systemName: completed ? "star.fill" : "star")
                                    .foregroundColor(completed ? .yellow : .gray)
                                
                            }
                        }
                    }
                    .padding(.vertical, 10)
                    .listRowSeparator(.hidden)
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
        .onAppear {
            Task {
                await viewModel.getCollectionMangas()
            }
        }
    }
}

#Preview {
    MyListView(tabSelection: .constant(1), viewModel: .test)
}
