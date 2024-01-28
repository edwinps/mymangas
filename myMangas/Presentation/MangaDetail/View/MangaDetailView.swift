//
//  MangaDetailView.swift
//  myMangas
//
//  Created by epena on 14/1/24.
//

import SwiftUI

struct MangaDetailView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: MangaDetailViewModel
    
    init(viewModel: MangaDetailViewModel) {
        self.viewModel = viewModel
        UIScrollView.appearance().bounces = false
    }
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    mangaImage(manga: viewModel.manga)
                        .background(
                            GeometryReader { geometry in
                                Color.clear
                                    .preference(key: ScrollViewOffsetKey.self, value: geometry.frame(in: .named("scrollView")).origin.y)
                            }.onPreferenceChange(ScrollViewOffsetKey.self) { offset in
                                viewModel.calculateNavBarOpacity(offset: offset,
                                                                 topInsetSize: UIDevice.topInsetSize)
                            }
                        )
                    HeaderView()
                    
                    if let synopsis = viewModel.manga.sypnosis {
                        Text("Synopsis:")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding([.leading, .trailing])
                        Text(synopsis)
                            .padding([.leading, .trailing])
                    }
                    Spacer()
                }
            }
            .navigationDestination(for: Int.self) { _ in
                MangaEditView(viewModel: MangaEditViewModel(manga: viewModel.manga))
            }
            .ignoresSafeArea(edges: .top)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden()
            .coordinateSpace(name: "scrollView")
            NavigationBarTitleView(title: viewModel.manga.title)
                .opacity(viewModel.navBarOpacity)
            
            Button(action: { dismiss() }, label: {
                HStack() {
                    Image(systemName: "arrow.left")
                        .imageScale(.large)
                        .foregroundColor(.primary)
                    Spacer()
                }.padding([.leading])
            }).padding(.top, 6)
            
        }.environmentObject(viewModel)
    }
}

private extension MangaDetailView {
    struct mangaImage: View {
        let manga: Manga
        @EnvironmentObject var viewModel: MangaDetailViewModel
        
        var body: some View {
            AsyncImage(url: manga.mainPicture) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .onAppear {
                        viewModel.imageHeigt = 500
                    }
            } placeholder: {
                Color.gray
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                    .overlay(
                        VStack {
                            Spacer()
                            Text(manga.titleJapanese ?? manga.title)
                                .foregroundColor(.white)
                                .font(.title)
                                .bold()
                        }
                    )
                    .onAppear {
                        viewModel.imageHeigt = 50
                    }
            }
        }
    }
}




#Preview {
    NavigationStack {
        MangaDetailView(viewModel: MangaDetailViewModel.test)
    }
}

