//
//  MangaDetailView.swift
//  myMangas
//
//  Created by epena on 14/1/24.
//

import SwiftUI

struct MangaDetailView: View {
    @ObservedObject var viewModel: MangaDetailViewModel
    @State private var imageOffset: CGFloat = 0
    init(viewModel: MangaDetailViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    mangaImage(manga: viewModel.manga)
                        .offset(y: viewModel.imageOffset)
                        .background(
                            GeometryReader { geometry in
                                Color.clear
                                    .preference(key: ScrollViewOffsetKey.self, value: geometry.frame(in: .named("scrollView")).origin.y)
                            }.onPreferenceChange(ScrollViewOffsetKey.self) { offset in
                                viewModel.calculateNavBarOpacityAndImageOffset(
                                    offset: offset,
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
            .ignoresSafeArea(edges: .top)
            .coordinateSpace(name: "scrollView")
            .navigationTitle("")
            .navigationBarBackButtonHidden()
            NavigationBarTitleView(title: viewModel.manga.title)
                .opacity(viewModel.navBarOpacity)
            
            backButton().padding([.leading])
            
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

