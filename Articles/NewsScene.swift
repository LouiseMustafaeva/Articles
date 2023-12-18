//
//  NewsScene.swift
//  Articles
//
//  Created by Louise on 18/12/23.
//

import SwiftUI
import CoreData

struct NewsScene: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NewsCell(title: "", subTitle: "", image: "")
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("News")
        }
    }
}

struct NewsScene_Previews: PreviewProvider {
    static var previews: some View {
        NewsScene().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
