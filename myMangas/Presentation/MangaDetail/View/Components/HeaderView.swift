//
//  HeaderView.swift
//  myMangas
//
//  Created by epena on 27/1/24.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var viewModel: MangaDetailViewModel
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            Text(viewModel.manga.title)
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    GeometryReader { geometry in
                        Color.clear
                            .preference(key: ScrollViewOffsetKey.self,
                                        value: geometry.frame(in: .named("scrollView")).origin.y)
                    }.onPreferenceChange(ScrollViewOffsetKey.self) { offset in
                        viewModel.calculateNavTitleOpacity(offset: offset)
                    }
                )
            
            if !viewModel.manga.genres.isEmpty {
                HStack {
                    Image(systemName: "square.grid.2x2").font(.footnote)
                    Text("\(viewModel.manga.genres.map {$0.capitalized }.joined(separator: " | "))")
                }
            }
            
            if !viewModel.manga.demographics.isEmpty {
                HStack {
                    Image(systemName: "tag").font(.footnote)
                    Text("\(viewModel.manga.demographics.map { $0.rawValue.capitalized }.joined(separator: " | "))")
                }
            }
            
            if let volumes = viewModel.manga.volumes {
                HStack {
                    Image(systemName: "book").font(.footnote)
                    Text("\(volumes) volumes")
                }
            }
            NavigationLink(value: MangaNavigation.edit(viewModel)) {
                HStack {
                    Image(systemName: "plus")
                    Text("Add to your collection")
                    
                }
            }
        }
        .padding([.leading, .trailing])
        .background(Color.primary.colorInvert())
    }
}

struct NavigationBarTitleView: View {
    var title: String
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: MangaDetailViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Color.primary.colorInvert()
                .frame(height: UIDevice.topInsetSize)
            HStack(alignment: .center) {
                Text(viewModel.manga.title)
                    .lineLimit(2)
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding([.horizontal], 40)
                    .opacity(viewModel.titteBarOpacity)
            }.frame(maxWidth: .infinity)
                .background(Color.primary.colorInvert())
            Divider()
        }
        .animation(.default, value: viewModel.titteBarOpacity)
        .ignoresSafeArea(edges: .top)
    }
}

struct ScrollViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    HeaderView()
        .environmentObject(MangaDetailViewModel.test)
    
}
