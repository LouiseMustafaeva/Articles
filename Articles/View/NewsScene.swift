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
    
    @ObservedObject var viewModel = ArticlesViewModel()
    @State private var searchText = ""
    
    var screenType: ScreenType
    var body: some View {
        NavigationView {
            List {
                ForEach(items){ item in
                    NavigationLink {
                        DetailScene(imageUrl: item.imageUrl ?? "", title: item.title ?? "", author: item.author ?? "", date: item.date ?? "", content: item.subTitle ?? "")
                    } label: {
                        NewsCell(title: item.title ?? "", subTitle: item.subTitle ?? "", imageUrl: item.imageUrl ?? "")
                    }.navigationBarTitleDisplayMode(.large)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                }
            }.onAppear{
                viewModel.getData(screenType: screenType, items: items, viewContext: viewContext)
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("News")
            .searchable(text: $searchText, prompt: "Search title")
            .onChange(of: searchText){ value in
                if (searchText != ""){
                    items.nsPredicate = NSPredicate(format: "title CONTAINS[c] %@", searchText)
                } else {
                    items.nsPredicate = nil
                }
            }
        }
    }
}

struct NewsScene_Previews: PreviewProvider {
    static var previews: some View {
        NewsScene(screenType: .home).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
