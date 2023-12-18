//
//  NewsScene.swift
//  Articles
//
//  Created by Louise on 18/12/23.
//

import SwiftUI
import CoreData

struct NewsScene: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.title, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    var screenType: ScreenType
    var body: some View {
        NavigationView {
                List {
                    ForEach(items){ item in
                        NavigationLink {
                            DetailScene(imageUrl: item.imageUrl ?? "", title: item.title ?? "", author: item.author ?? "", date: item.date ?? "", content: item.subTitle ?? "")
                        } label: {
                            NewsCell(title: item.title ?? "", subTitle: item.subTitle ?? "", imageUrl: item.imageUrl ?? "")
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                        }.navigationBarTitleDisplayMode(.large)
                    }
                }.onAppear{
                    let viewModel = ArticlesViewModel()
                    viewModel.getData(screenType: screenType, items: items, viewContext: viewContext)
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("News")
        }
    }
}

struct NewsScene_Previews: PreviewProvider {
    static var previews: some View {
        NewsScene(screenType: .home).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
