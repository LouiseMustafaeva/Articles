//
//  SportScene.swift
//  Articles
//
//  Created by Louise on 18/12/23.
//

import SwiftUI

struct SportScene: View {
    
    @ObservedObject var viewModel = ArticlesViewModel()
    
    var screenType: ScreenType
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.sportNews, id: \.self){ item in
                    
                    NavigationLink {
                        DetailScene(imageUrl: item.urlToImage ?? "", title: item.title ?? "", author: item.author ?? "", date: item.publishedAt ?? "", content: item.description ?? "")
                    } label: {
                        NewsCell(title: item.title ?? "", subTitle: item.description ?? "", imageUrl: item.urlToImage ?? "")
                    }.navigationBarTitleDisplayMode(.large)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                }
            }.onAppear{
                viewModel.getDataFromNetwork(screenType: screenType)
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Sport")
        }
    }
}

struct SportScene_Previews: PreviewProvider {
    static var previews: some View {
        SportScene(screenType: .sport)
    }
}
